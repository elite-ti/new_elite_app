toggle_fields = (false_radio_button, fields) ->
  if false_radio_button.prop('checked') == true
    fields.prop('value', '').prop('disabled', true)
  else
    fields.prop('disabled', false)

toggle_graduated_fields = () ->
  toggle_fields($('#teacher_graduated_false'), $('#teacher_major_id, #teacher_institute'))

toggle_post_graduated_fields = () ->
  toggle_fields($('#teacher_post_graduated_false'), $('#teacher_post_graduated_comment'))

jQuery ->
  $("#teacher_subject_ids").on "change", ->
    if $("#teacher_subject_ids_chzn ul").html().indexOf("EDUCAÇÃO FÍSICA") != -1
      $("#has_cref").show()
    else
      $("#has_cref").hide()

  # Toggle fields
  toggle_graduated_fields()
  $('#teacher_graduated').click -> toggle_graduated_fields()
  $('#teacher_major_id').click ->
    $('#teacher_graduated_true').prop('checked', true) if $(this).prop('value') != ''

  toggle_post_graduated_fields()
  $('#teacher_post_graduated').click -> toggle_post_graduated_fields()
  $('#teacher_post_graduated_comment').keydown ->
    $('#teacher_post_graduated_true').prop('checked', true)