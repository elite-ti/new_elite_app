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
  
  def title(page_title)
    content_for(:title) { ' - ' + page_title }
    content_tag :div, id: 'title' do
      content_tag(:h1, page_title) +
      content_tag(:div, '', id: 'sep_line')
    end
  end

  # def chosen_buttons
  #   content_tag(:button, 'All', class: 'select_all') +
  #     content_tag(:button, 'None', class: 'select_none')
  # end

  def period_input(builder, attribute)
    builder.input attribute, collection: 0..5, :prompt => "-", label_method: lambda { |x| pluralize x, "dia" }
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def color(time_table)
    return 'red' if time_table.teacher_absence
    return 'green' if time_table.past?
    return 'yellow' if time_table.future?
    nil
  end
end
