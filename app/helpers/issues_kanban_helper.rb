module IssuesKanbanHelper
  def color_of_user(x)
    "rgb(" + (Digest::MD5.hexdigest(x.login)[0..5].split(/(..)/).select { |x| x != "" }.map { |x| 255 - (x.to_i(16) % 64) }).to_a.join(",") + ")"
  end

  def user_section_title(user_id, status)
    (user_id == 0 ? "(Someone)" : link_to_user(User.find(user_id))) + " (#{@status_assignee_estimated_hours[status.id][user_id]} hr)";
  end
end

