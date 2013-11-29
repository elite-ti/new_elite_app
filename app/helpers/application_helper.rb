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
    link_to 'Destroy', object, method: :delete, confirm: 'Are you sure?'
  end

  def tooltip(content, options = {}, html_options = {}, *parameters_for_method_reference)
    html_options[:title] = options[:tooltip]
    html_options[:class] = html_options[:class] || 'tooltip'
    content_tag("span", content, html_options) 
  end

  def proper_greeting
    return ["Bom noite", "Bom dia", "Boa tarde", "Boa noite"][DateTime.now.in_time_zone("Brasilia").strftime('%H').to_i/6]
  end
end
