require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare do
  require_dependency 'issue'
end

require_dependency 'issues_sidebar_graph_hook'

Redmine::Plugin.register :redmine_issues_kanban do
  name 'Redmine Issues Kanban Plugin'
  author 'gugod'
  description 'Provide a kanban view for the issues page'
  version '0.01'
end
