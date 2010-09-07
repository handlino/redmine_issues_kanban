class IssuesKanbanController < ApplicationController
  unloadable
  helper :issues
  include IssuesHelper

  helper :queries
  include QueriesHelper

  before_filter :find_project, :only => [:index]
  before_filter :find_version, :only => [:index]
  before_filter :find_issues,  :only => [:index]

  def index
    @statuses = IssueStatus.all(:order => "position asc")

    @status_issues = {}
    @status_estimated_hours = {}
    @statuses.each do |status|
      @status_issues[status.id] = @issues.find_all { |x| x.status_id == status.id }
      @status_estimated_hours[status.id] = @status_issues[status.id].map(&:estimated_hours).map(&:to_f).sum
    end

  rescue ActiveRecord::RecordNotFound
    render_404
  end

  private

  def find_project
    if project_id = (params[:issue] && params[:issue][:project_id]) || params[:project_id]
      @project = Project.find(project_id)
    end
  end

  def find_version
    return unless @project

    @versions = @project.shared_versions || []
    @versions += @project.rolled_up_versions.visible if @with_subprojects
    @versions = @versions.uniq.sort
    @versions.reject! {|version| version.closed? || version.completed? } unless params[:completed]

    if params[:version]
      @version = @project.shared_versions.find(params[:version])
    end
  end


  def find_issues
    issues_finder = { :include => [:assigned_to, :tracker, :priority, :category, :fixed_version], :order => "issues.assigned_to_id DESC, enumerations.position DESC" }

    if @project
      conditions = {}
      if @version
        conditions[:fixed_version_id] = @version.id
      end
      issues_finder[:conditions] = conditions

      @issues = @project.issues.find(:all, issues_finder)
    else
      retrieve_query

      @query.group_by = nil
      @issues = @query.issues(issues_finder)
    end
  end

end
