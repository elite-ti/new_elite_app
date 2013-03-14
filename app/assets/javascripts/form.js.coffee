form_input_bindings = () ->
  $('.form-inputs select').chosen
    allow_single_deselect: true
    no_results_text: "No results matched"

  $('.form-inputs .date_time_picker').datetimepicker
    dateFormat: "dd/mm/yy"

  $('.form-inputs .date_picker').datepicker
    dateFormat: "dd/mm/yy"

jQuery ->
  form_input_bindings()

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    form_input_bindings()
    event.preventDefault()

  