require 'redmine'

require_dependency 'issues_sidebar_graph_hook'

Redmine::Plugin.register :redmine_issues_kanban do
  name 'Redmine Issues Kanban Plugin'
  author 'Handlino Inc.'
  description 'Provide a kanban view for the issues page'
  version '0.01'

  project_module :issues_kanban do
    permission :show_issues_kanban, :issues_kanban => :index, :public => true
  end

  menu :project_menu, :issues_kanban, { :controller => 'issues_kanban', :action => 'index' }, :param => :project_id, :before => :activity
end
