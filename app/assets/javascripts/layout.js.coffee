jQuery ->
  $('#select_roles').change ->
    location.href = '/change_role/' + $(this).val()

  $('.is-datatable').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true

  $('.tabs').tabs()

  $('.is-chosen').chosen
    allow_single_deselect: true