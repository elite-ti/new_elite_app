jQuery ->
  $('#mock_student_ra').change ->
    $('#student_exam_student_id').val($(this).val())
    $('#student_exam_student_id').trigger("liszt:updated")
    
  $('#student_exam_student_id').change ->
    $('#mock_student_ra').val($(this).val())
    $('#mock_student_ra').trigger("liszt:updated")

  $('.edit_student_exam').submit ->
    $('.error').remove()
    submit = true
    if $(this).find('#student_exam_student_id').val() == ''
      $('#student_exam_student_id').closest('.input').append('<span class="error">can\'t be blank</span>')
      submit = false
    if $(this).find('#student_exam_student_name').val() == ''
      $('#student_exam_student_name').closest('.input').append('<span class="error">can\'t be blank</span>')
      submit = false
    if $(this).find('#student_exam_student_enrolled_super_klazz_ids').val() == null 
      $('#student_exam_student_enrolled_super_klazz_ids').closest('.input').append('<span class="error">can\'t be blank</span>')
      submit = false
    if $(this).find('#student_exam_exam_execution_id').val() == ''
      $('#student_exam_exam_execution_id').closest('.input').append('<span class="error">can\'t be blank</span>')
      submit = false
    if $(this).find('#student_exam_student_number').val() == ''
      $('#student_exam_student_number').closest('.input').append('<span class="error">can\'t be blank</span>')
    if $(this).find('#student_exam_string_of_answers').val() == ''
      $('#student_exam_string_of_answers').closest('.input').append('<span class="error">can\'t be blank</span>')


    return submit
