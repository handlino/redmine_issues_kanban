module IssuesKanbanHelper
  def color_of_user(x)
    "rgb(" + (Digest::MD5.hexdigest(x.login)[0..5].split(/(..)/).select { |x| x != "" }.map { |x| 255 - (x.to_i(16) % 64) }).to_a.join(",") + ")"
  end

  def user_section_title(user, status)
    user_id = user ? user.id : 0
    (user ? link_to_user(user) : "(Someone)") + " (#{user_estimated_hours(user, status)} hr)";
  end

  def user_estimated_hours(user, status)
    user_issues(user, status).map { |x| x.estimated_hours.to_f }.sum
  end

  def user_issues(user, status)
    user_id = user ? user.id : nil
    @issues.find_all { |x| x.assigned_to_id == user_id && x.status_id == status.id }.to_a
  end
end
