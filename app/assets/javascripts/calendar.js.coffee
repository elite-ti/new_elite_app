# getters

selected = () -> $('#selected')
box = () -> $('#time_table_box')
form = () -> $('#time_table_box').find('form')
chosen_fields = () -> 
  $('#time_table_teacher_id, 
    #time_table_subject_id, 
    #time_table_teacher_absence_attributes_teacher_id, 
    #time_table_teacher_absence_attributes_subject_id')
optional_fields = () -> $('#teacher_absence_fields')

# helpers

set_chosen = (type) ->
  chosen_fields().chosen
    allow_single_deselect: true
    no_results_text: "No results matched"
  for field in $('#time_table_teacher_absence_attributes_absence_reason_id,
    #time_table_teacher_absence_attributes_teacher_id,
    #time_table_teacher_absence_attributes_subject_id')
    if $(field).val() != ''
      $('#teacher_absence_fields_check_box').prop('checked', true)
  toggle_optional_fields($('#teacher_absence_fields_check_box')[0], $('#teacher_absence_fields'))
  box().show()

submit = (type) ->
  request = $.ajax
    url: form().attr('action')
    data: form().serialize()
    dataType: 'script'
    type: type
  request.done ->
    set_time_tables_size()
    unselect()
    # set_box_position()
    # set_chosen type

set_time_tables_size = (cells = $('.cell')) ->
  for cell in cells
    time_tables = $(cell).find('.time_table')
    length = time_tables.length
    if length > 1
      for time_table in time_tables
        $(time_table).width 130/(length-1)-1
      time_tables.last().width 20
    else
      time_tables.first().width 150

set_box_position = () ->
  box().css('top', selected().position().top + selected().outerHeight())
  box().css('left', selected().position().left-1)
  
scroll = () ->
  if box().offset().top + box().height() > $(window).height() + $(window).scrollTop()
    $('html, body').animate
      scrollTop: selected().offset().top
      1000

unselect = () ->
  selected().removeAttr('id')
  box().hide()

select = (time_table) ->
  unselect()
  time_table.attr('id', 'selected')
  set_box_position()

new_time_table = () ->
  position = selected().closest('tr').find('td').first().attr('data-position')
  index = selected().closest('tr').find('td').index(selected().closest('td'))
  date = $($('tr').first().children('td').get(index)).attr('data-date')
  klazz_id = $($('tr').first().children('td').first()).attr('data-klazz-id')
  request = $.getScript '/time_tables/new?position=' + position + '&date=' + date + '&klazz_id=' + klazz_id
  request.done -> 
    set_chosen 'POST'
    scroll()

edit_time_table = () ->
  request = $.getScript '/time_tables/' + selected().find('.time_table_id').text() + '/edit'
  request.done -> 
    set_chosen 'PUT'
    scroll()

delete_time_table = (url) ->
  if confirm "Are you sure?"
    request = $.ajax
      url: url
      type: 'DELETE'
      dataType: 'script'
    request.done ->
      selected().parent().remove()
      box().hide()
      set_time_tables_size()

toggle_optional_fields = (checkbox, fields) ->
  if fields.length > 0
    if checkbox.checked then fields.show() else fields.hide()

jQuery ->

  set_time_tables_size()
  box().hide()

  $('#date').datepicker
    dateFormat: 'yy-mm-dd'

  $('#close_form').click ->
    unselect()
    return false

  $(document).on 'click', '#teacher_absence_fields_check_box', ->
      toggle_optional_fields(this, $('#teacher_absence_fields'))
      $('#time_table_teacher_absence_attributes__destroy').attr('value', if this.checked then false else true)

  $(document).on 'click', '.new', ->
    select($(this).children('.time_table'))
    new_time_table()
    return false

  $(document).on 'click', '.new_from_form', ->
    select(selected().parent().siblings().last().find('.time_table'))
    new_time_table()
    return false

  $(document).on 'click', '.create', ->
    submit('POST')
    return false

  $(document).on 'click', '.edit', ->
    select($(this).children('.time_table'))
    edit_time_table()
    return false

  $(document).on 'click', '.update', ->
    submit('PUT')
    return false

  $(document).on 'click', '.destroy', ->
    delete_time_table(this.href)
    return false
    
  $(document).on 'click', '.destroy_all', ->
    delete_time_table(this.href + '?replicate=1')
    return false