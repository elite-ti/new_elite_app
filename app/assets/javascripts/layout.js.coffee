jQuery ->
  # $('#flash').delay(3000).fadeOut()

  $('#select_roles').change ->
    location.href = 'change_role/' + $(this).val()

  $('.is-datatable').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true

  $('.is-chosen').chosen()

  $('.tabs').tabs
    cache: true
    load: (event, ui) ->
      $(ui.panel).delegate 'a', 'click', (event) ->
        $(ui.panel).load(this.href)
        event.preventDefault()
      # load_datatable $(ui.panel).find('.datatable')


