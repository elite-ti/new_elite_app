toggle_role = (checkbox, field) ->
  if checkbox.prop('checked') == true
    field.show()
    field.children('.destroy').val('')
  else
    field.hide()
    field.children('.destroy').val('1')

toggle_roles = () ->
  toggle_role($('#employee_roles_teacher'), $('#teacher_fields'))
  toggle_role($('#employee_roles_campus_head_teacher'), $('#campus_head_teacher_fields'))
  toggle_role($('#employee_roles_product_head_teacher'), $('#product_head_teacher_fields'))
  toggle_role($('#employee_roles_subject_head_teacher'), $('#subject_head_teacher_fields'))
  toggle_role($('#employee_roles_campus_principal'), $('#campus_principal_fields'))

toggle_fields = (false_radio_button, fields) ->
  if false_radio_button.prop('checked') == true
    fields.prop('value', '').prop('disabled', true)
  else
    fields.prop('disabled', false)

toggle_graduated_fields = () ->
  toggle_fields(
    $('#employee_teacher_attributes_graduated_false'), 
    $('#employee_teacher_attributes_major_id, #employee_teacher_attributes_institute')
  )

toggle_post_graduated_fields = () ->
  toggle_fields(
    $('#employee_teacher_attributes_post_graduated_false'),
    $('#employee_teacher_attributes_post_graduated_comment')
  )

jQuery ->
  # Roles
  toggle_roles()
  $('#employee_roles').click -> toggle_roles()

  # jQuery Mask
  $(".telephone_input").mask("(99)9999-9999")
  $("#employee_cpf").mask("999.999.999-99")
  $('form').submit ->
    $(".telephone_input, #personal_info_cpf").each (index, element) =>
      $(element).prop('value', $(element).prop('value').replace(/\D/g,''))

  # Toggle fields
  toggle_graduated_fields()
  $('#person_graduated').click -> toggle_graduated_fields()
  $('#employee_teacher_attributes_major_id').click ->
    $('#employee_teacher_attributes_graduated_true').prop('checked', true) if $(this).prop('value') != ''

  toggle_post_graduated_fields()
  $('#employee_post_graduated').click -> toggle_post_graduated_fields()
  $('#employee_teacher_attributes_post_graduated_comment').keydown ->
    $('#employee_teacher_attributes_post_graduated_true').prop('checked', true)



  

  

  

  
