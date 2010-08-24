class IssuesSidebarGraphHook < Redmine::Hook::ViewListener
  def view_issues_sidebar_issues_bottom(context = {})
    p = context[:project].nil? ? {} : { :project_id => context[:project] }

    return link_to(l(:issues_kanban), { :controller => 'issues_kanban', :action => 'index', :only_path => true}.merge(p))
  end
end
