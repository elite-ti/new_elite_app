module ResourceHelper
  def show_group(subtitle, fields)
    return nil if fields.values.select{ |x| not invalid?(x) }.empty?
    result = invalid?(subtitle) ? h('') : content_tag(:h2, subtitle)
    fields.each do |label, value|
      result += show_field(label, value)
    end
    result
  end

  def show_field(label, value)
    return '' if invalid?(value)
    content_tag(:p, content_tag(:span, label + ': ') + value)
  end

  def invalid?(string)
    string.nil? or string.blank?
  end
end