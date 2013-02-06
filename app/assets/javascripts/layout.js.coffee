jQuery ->
  $('#select_roles').change ->
    location.href = 'change_role/' + $(this).val()

  $('.is-datatable').dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true

  $('.tabs').tabs
    cache: true
    load: (event, ui) ->
      $(ui.panel).delegate 'a', 'click', (event) ->
        $(ui.panel).load(this.href)
        event.preventDefault()

  $('.is-chosen').chosen
    allow_single_deselect: true