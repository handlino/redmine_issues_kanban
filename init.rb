require 'redmine'

require_dependency 'issues_sidebar_graph_hook'

Redmine::Plugin.register :redmine_issues_kanban do
  name 'Redmine Issues Kanban Plugin'
  author 'Handlino Inc.'
  description 'Provide a kanban view for the issues page'
  version '0.01'

  permission :issues_kanban, { :issues_kanban => [ :index ] }, :public => true

  menu(:project_menu, :issues_kanban, { :controller => 'issues_kanban', :action => 'index' }, :caption => :issues_kanban, :param => :project_id)
end
