ActionController::Routing::Routes.draw do |map|
  map.connect 'projects/:project_id/issues_kanban', :controller => 'issues_kanban', :action => 'index'
end
