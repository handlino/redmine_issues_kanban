class IssuesKanbanController < ApplicationController
  unloadable
  include QueriesHelper
  helper :issues

  before_filter :find_project, :only => [:index]

  def index
    retrieve_query

    if @query.valid?
      @statuses = IssueStatus.all
      @issues = @query.issues(:include => [:assigned_to, :tracker, :priority, :category, :fixed_version])
    else
      render_404
    end

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
