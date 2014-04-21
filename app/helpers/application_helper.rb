#encoding: utf-8

module ApplicationHelper
  def flash_message(flash)
    flash.each do |key, msg|
      return content_tag :div, content_tag(:p, msg), id: 'flash'
    end
    nil
  end

  def select_roles(current_employee, current_role)
    options = ''
    current_employee.roles.each do |role|
      if role == current_role
        options = options + "<option value='#{role}' selected='selected'>#{role.titleize}</option>"
      else
        options = options + "<option value='#{role}'>#{role.titleize}</option>"
      end
    end
    select_tag 'roles', options.html_safe, id: 'select_roles'
  end
  
  def title(page_title, *links)
    content_for(:title) { ' - ' + page_title }
    content_tag :div, id: 'title' do
      content_tag(:h1, page_title) +
      links(links) +
      content_tag(:div, '', id: 'sep_line')
    end
  end

  def links(links)
    content_tag(:span) do
      links.compact.reduce do |sum, link|
        sum + ' | ' + link 
      end
    end
  end

  def print_sortable_date(date)
    date.present? ? date.strftime('%Y-%m-%d') : ''
  end

  def print_date(date)
    date.present? ? date.strftime('%d/%m/%Y') : ''
  end

  def print_datetime(datetime)
    datetime.present? ? datetime.strftime('%d/%m/%Y %H:%M') : ''
  end

  def print_long_string(string, divide_in)
    string.present? ? string.split('').in_groups_of(divide_in).map(&:join).join(' ') : ''
  end

  def destroy_link(object)
    link_to 'Deletar', object, method: :delete, confirm: 'Você tem certeza?'
  end

  def tooltip(content, options = {}, html_options = {}, *parameters_for_method_reference)
    html_options[:title] = options[:tooltip]
    html_options[:class] = html_options[:class] || 'tooltip'
    content_tag("span", content, html_options) 
  end

  def proper_greeting
    greetings = ["Bom noite", "Bom dia", "Boa tarde", "Boa noite"]
    index = DateTime.now.in_time_zone("Brasilia").strftime('%H').to_i/6
    return greetings[index]
  end

  def translate_campus_by_name input
    translations = {
      'bangu' => '1',
      'bg' => '1',
      'b' => '1',
      'cg1' => '2',
      'campogrande1' => '2',
      'cgi' => '2',
      'campograndei' => '2',
      'cg2' => '3',
      'campogrande2' => '3',
      'cgii' => '3',
      'campograndeii' => '3',
      'ig' => '4',
      'ilha' => '4',
      'ilhadogovernador' => '4',
      'mad1' => '5',
      'madureira1' => '5',
      'm1' => '5',
      'mad2' => '6',
      'madureira2' => '6',
      'm2' => '6',
      'mad3' => '7',
      'madureira3' => '7',
      'm3' => '7',
      'norteshopping' => '8',
      'ns' => '8',
      'novaiguacu' => '9',
      'ni' => '9',
      'sg1' => '10',
      'saogoncalo1' => '10',
      'sgi' => '10',
      'saogoncaloi' => '10',
      'sg2' => '11',
      'saogoncalo2' => '11',
      'sgii' => '11',
      'saogoncaloii' => '11',
      'taquara' => '12',
      't' => '12',
      'tq' => '12',
      'r9' => '12',
      'tijuca' => '13',
      'tj' => '13',
      'vilavalqueire' => '14',
      'valqueire' => '14',
      'v' => '14',
      'vv' => '14',
      'val' => '14'
    }
    if translations.keys.include? input
      translations[input]
    else
      input
    end
  end
end
