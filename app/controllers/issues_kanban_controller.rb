class IssuesKanbanController < ApplicationController
  unloadable
  helper :issues

  before_filter :find_project, :only => [:index]

  def index
    # @versions = @project.shared_versions || []
    # @versions += @project.rolled_up_versions.visible if @with_subprojects
    # @versions = @versions.uniq.sort
    # @versions.reject! {|version| version.closed? || version.completed? } unless params[:completed]

    @statuses = IssueStatus.all(:order => "position asc")
    @issues = @project.issues(:include => [:assigned_to, :tracker, :priority, :category, :fixed_version])

  rescue ActiveRecord::RecordNotFound
    render_404
  end

  private

  def find_project
    project_id = (params[:issue] && params[:issue][:project_id]) || params[:project_id]
    @project = Project.find(project_id)

  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
