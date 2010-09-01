class IssuesSidebarGraphHook < Redmine::Hook::ViewListener
  def view_issues_sidebar_issues_bottom(context = {})
    output = ""
    if context[:project]
      output = link_to(l(:issues_kanban), { :controller => 'issues_kanban', :action => 'index', :only_path => true, :project_id => context[:project]}) + '<br />'
    else
      output = link_to(l(:issues_kanban), { :controller => 'issues_kanban', :action => 'index', :only_path => true}) + '<br />'
    end

    return output
  end
end
