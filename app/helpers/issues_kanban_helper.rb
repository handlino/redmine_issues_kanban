module IssuesKanbanHelper
  def color_of_user(x)
    "rgb(" + (Digest::MD5.hexdigest(x.login)[0..5].split(/(..)/).select { |x| x != "" }.map { |x| 255 - (x.to_i(16) % 64) }).to_a.join(",") + ")"
  end
end
