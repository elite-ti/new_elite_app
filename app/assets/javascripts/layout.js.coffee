jQuery ->
  $('#flash').delay(3000).fadeOut()

  $('#select_roles').change ->
    location.href = 'change_role/' + $(this).val()

  $('.is-datatable,
      #product_types, #products, #years, #campuses, #klazzes, #subjects, #employees, #klazz_types, #majors, 
    	#elite_roles, #school_roles, #absence_reasons, #product_groups, #people, #teacher_absences, 
      #polls, #poll_question_types, #poll_question_categories').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true

  $('.is-chosen').chosen()