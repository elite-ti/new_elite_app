#encoding: utf-8

class TelephoneInput < SimpleForm::Inputs::StringInput
  def input
    input_html_options[:placeholder] = 'Somente números'
    super
  end
  
  def input_html_classes
    super.push('telephone_input')
  end
end