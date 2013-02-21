jQuery ->
  $('#select_roles').change ->
    location.href = '/change_role/' + $(this).val()

  $('.is-datatable').dataTable
    sPaginationType: 'full_numbers'
    bJQueryUI: true

  $('.tabs').tabs()

  $('.is-chosen').chosen
    allow_single_deselect: true


  $('.telephone_input').mask('(99) 9999-9999')
  $('.cpf_input').mask('999.999.999-99')
  $('.cep_input').mask('99.999-999')
  $('form').submit ->
    $('.telephone_input, .cpf_input, .cep_input').each (index, element) =>
      $(element).prop('value', $(element).prop('value').replace(/\D/g,''))