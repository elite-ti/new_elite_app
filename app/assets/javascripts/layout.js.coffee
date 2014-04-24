jQuery ->
  $('#select_roles').change ->
    location.href = '/change_role/' + $(this).val()

  $('.is-datatable').dataTable
    sPaginationType: 'full_numbers'
    bJQueryUI: true

  $('.is-datatable-exams').dataTable
    sPaginationType: 'full_numbers'
    bJQueryUI: true
    aaSorting: [[ 0, "desc" ], ["1", "asc"]]    
    aoColumns: [
      {sWidth:"12%"},
      {sWidth:"27%"},
      {sWidth:"21%"},
      {sWidth:"26%"},
      {sWidth:"7%"},
      {sWidth:"7%"}
    ]

  $('.is-one-page-datatable').dataTable
    sPaginationType: 'full_numbers'
    bJQueryUI: true
    bPaginate: false
    aaSorting: [[ $(".is-one-page-datatable").find("th").length - 1, "desc" ]]

  $('.is-datatable-desc').dataTable
    sPaginationType: 'full_numbers'
    bJQueryUI: true
    aaSorting: [[ 0, "desc" ]]    

  $('.is-datatable-exam-executions').dataTable
    sPaginationType: 'full_numbers'
    bJQueryUI: true
    aaSorting: [[ 0, "desc" ], ["1", "asc"]]    
    aoColumns: [
      {sWidth:"5%"},
      {sWidth:"54%"},
      {sWidth:"41%"}
    ]

  $('.is-remote-datatable').dataTable
    sPaginationType: 'full_numbers'
    bJQueryUI: true
    bProcessing: true
    bServerSide: true
    bAutoWidth: false
    aoColumns: [
      {sWidth:"35%"},
      {sWidth:"15%"},
      {sWidth:"15%"},
      {sWidth:"10%"},
      {sWidth:"10%"},
      {sWidth:"15%"}
    ]
    sAjaxSource: $('#products').data('source')
    aaSorting: [[ 1, "desc" ]]    

  $('.tabs').tabs()

  $('.is-chosen').chosen
    allow_single_deselect: true

  $('.date').mask('99/99/9999')
  $('.telephone_input').mask('(99) 9999-9999')
  $('.cpf_input').mask('999.999.999-99')
  $('.cep_input').mask('99.999-999')
  $('form').submit ->
    $('.telephone_input, .cpf_input, .cep_input').each (index, element) =>
      $(element).prop('value', $(element).prop('value').replace(/\D/g,''))