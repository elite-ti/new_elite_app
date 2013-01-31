jQuery ->
  # $('#flash').delay(3000).fadeOut()

  $('#select_roles').change ->
    location.href = 'change_role/' + $(this).val()

  $('.is-datatable').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true

  $('.form-inputs select').chosen()

  $('.tabs').tabs
    cache: true
    load: (event, ui) ->
      $(ui.panel).delegate 'a', 'click', (event) ->
        $(ui.panel).load(this.href)
        event.preventDefault()
      # load_datatable $(ui.panel).find('.datatable')


  # Nested form code
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).parent().before($(this).data('fields').replace(regexp, time))
    event.preventDefault()
