class DateTimeInput < SimpleForm::Inputs::DateTimeInput
  def input
    string_format = ''
    case input_type
    when :date
      string_format = '%d/%m/%Y'
    when :datetime
      string_format = '%d/%m/%Y %H:%M'
    end

    input_value = @builder.object.send(attribute_name)
    input_html_options[:value] = input_value.strftime(string_format) if input_value.present?
    @builder.text_field(attribute_name, input_html_options)
  end

  def input_html_classes
    case input_type
    when :date
      super.push('date_picker')
    when :datetime
      super.push('date_time_picker')
    end
  end
end
