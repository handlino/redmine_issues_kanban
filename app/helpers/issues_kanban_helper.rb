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


  # Based on https://github.com/henrik/slugalizer/blob/master/slugalizer.rb
  def slugalize(text, separator = "-")
    separators = %w[- _ +]
    unless separators.include?(separator)
      raise "Word separator must be one of #{separators}"
    end
    re_separator = Regexp.escape(separator)
    result = decompose(text.to_s)
    result.gsub!(/[^\x00-\x7F]+/, '') # Remove non-ASCII (e.g. diacritics).
    result.gsub!(/[^a-z0-9\-_\+]+/i, separator) # Turn non-slug chars into the separator.
    result.gsub!(/#{re_separator}{2,}/, separator) # No more than one of the separator in a row.
    result.gsub!(/^#{re_separator}|#{re_separator}$/, '') # Remove leading/trailing separator.
    result.downcase!
    result
  end

  def decompose(text)
    if defined?(ActiveSupport::Multibyte::Handlers) # Active Support <2.2
      ActiveSupport::Multibyte::Handlers::UTF8Handler.normalize(text, :kd).to_s
    else # ActiveSupport 2.2+
      ActiveSupport::Multibyte::Chars.new(text).normalize(:kd).to_s
    end
  end
end
