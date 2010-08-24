class IssuesKanbanController < ApplicationController
  unloadable
  helper :issues

  before_filter :find_project, :only => [:index]

  def index
    @statuses = IssueStatus.all
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
