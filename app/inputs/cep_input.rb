#encoding: utf-8

class CepInput < SimpleForm::Inputs::StringInput
  def input
    input_html_options[:placeholder] = 'Somente números'
    super
  end
  
  def input_html_classes
    super.push('cep_input')
  end
end