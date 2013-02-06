# getters

selected = () -> $('#selected')
box = () -> $('#klazz_period_box')
form = () -> $('#klazz_period_box').find('form')
chosen_fields = () -> 
  $('#klazz_period_teacher_id, 
    #klazz_period_subject_id, 
    #klazz_period_teacher_absence_attributes_teacher_id, 
    #klazz_period_teacher_absence_attributes_subject_id')
optional_fields = () -> $('#teacher_absence_fields')

# helpers

set_chosen = (type) ->
  chosen_fields().chosen
    allow_single_deselect: true
    no_results_text: "No results matched"
  for field in $('#klazz_period_teacher_absence_attributes_absence_reason_id,
    #klazz_period_teacher_absence_attributes_teacher_id,
    #klazz_period_teacher_absence_attributes_subject_id')
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
    set_klazz_periods_size()
    unselect()
    # set_box_position()
    # set_chosen type

set_klazz_periods_size = (cells = $('.cell')) ->
  for cell in cells
    klazz_periods = $(cell).find('.klazz_period')
    length = klazz_periods.length
    if length > 1
      for klazz_period in klazz_periods
        $(klazz_period).width 130/(length-1)-1
      klazz_periods.last().width 20
    else
      klazz_periods.first().width 150

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

select = (klazz_period) ->
  unselect()
  klazz_period.attr('id', 'selected')
  set_box_position()

new_klazz_period = () ->
  position = selected().closest('tr').find('td').first().attr('data-position')
  index = selected().closest('tr').find('td').index(selected().closest('td'))
  date = $($('tr').first().children('td').get(index)).attr('data-date')
  klazz_id = $($('tr').first().children('td').first()).attr('data-klazz-id')
  request = $.getScript '/klazz_periods/new?position=' + position + '&date=' + date + '&klazz_id=' + klazz_id
  request.done -> 
    set_chosen 'POST'
    scroll()

edit_klazz_period = () ->
  request = $.getScript '/klazz_periods/' + selected().find('.klazz_period_id').text() + '/edit'
  request.done -> 
    set_chosen 'PUT'
    scroll()

delete_klazz_period = (url) ->
  if confirm "Are you sure?"
    request = $.ajax
      url: url
      type: 'DELETE'
      dataType: 'script'
    request.done ->
      selected().parent().remove()
      box().hide()
      set_klazz_periods_size()

toggle_optional_fields = (checkbox, fields) ->
  if fields.length > 0
    if checkbox.checked then fields.show() else fields.hide()

jQuery ->

  set_klazz_periods_size()
  box().hide()

  $('#date').datepicker
    dateFormat: 'yy-mm-dd'

  $('#close_form').click ->
    unselect()
    return false

  $(document).on 'click', '#teacher_absence_fields_check_box', ->
      toggle_optional_fields(this, $('#teacher_absence_fields'))
      $('#klazz_period_teacher_absence_attributes__destroy').attr('value', if this.checked then false else true)

  $(document).on 'click', '.new', ->
    select($(this).children('.klazz_period'))
    new_klazz_period()
    return false

  $(document).on 'click', '.new_from_form', ->
    select(selected().parent().siblings().last().find('.klazz_period'))
    new_klazz_period()
    return false

  $(document).on 'click', '.create', ->
    submit('POST')
    return false

  $(document).on 'click', '.edit', ->
    select($(this).children('.klazz_period'))
    edit_klazz_period()
    return false

  $(document).on 'click', '.update', ->
    submit('PUT')
    return false

  $(document).on 'click', '.destroy', ->
    delete_klazz_period(this.href)
    return false
    
  $(document).on 'click', '.destroy_all', ->
    delete_klazz_period(this.href + '?replicate=1')
    return false