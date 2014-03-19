jQuery ->
  $('.form-inputs select').chosen
    allow_single_deselect: true
    no_results_text: "No results matched"

  $('.form-inputs .date_time_picker').datetimepicker
    dateFormat: "dd/mm/yy"

  $('.form-inputs .date_picker').datepicker
    dateFormat: "dd/mm/yy"

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).parent().before($(this).data('fields').replace(regexp, time))
    $('select').not('#select_roles').chosen()
    $('.chzn-container.chzn-container-single').children('.chzn-default').children('span').text($('.chzn-container.chzn-container-single').parent().children('select').data('value'))
    event.preventDefault()