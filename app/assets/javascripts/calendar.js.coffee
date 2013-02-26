border_width = 1
empty_period_width = 20

class Tab
  self: -> $('div#calendar_tab')
  goto_week: -> $('#date')
  next_prev_week: -> $('.navigation a')

  update: (url) ->
    $.get url, (data) =>
      @self().html(data)
      @bindings()
      @table = new Table() 

  bindings: =>
    @goto_week().datepicker
      dateFormat: 'dd/mm/yy'

    @goto_week().change (e) =>
      date_field = $(e.target)
      action = date_field.closest('form').get(0).action
      date = date_field.attr('value').split('/').reverse().join('-')
      @update(action + '?date=' + date)

    @next_prev_week().click (e) =>
      @update(e.target.href)
      return false


class Table
  constructor: ->
    @bindings()
    @form = new Form(this)
    @format()

  self: -> $('table.calendar')
  selected: -> $('.selected')
  cells: -> $('.cell')
  periods: -> $('.period')

  bindings: ->
    @periods().parent('a').click (e) =>
      @select($(e.target))
      return false

  format: ->
    for cell in @cells() 
      filled_periods = $(cell).find('.filled')
      number_of_filled = filled_periods.size()
      if number_of_filled == 0
        $(cell).find('.empty').width($(cell).width() + border_width)
      else
        width = ($(cell).width() - empty_period_width)/number_of_filled - border_width
        $(filled).width(width) for filled in filled_periods 
        $(cell).find('.empty').width(empty_period_width + border_width)

  select: (period) ->
    @deselect()
    period.addClass('selected')
    @form.update(period)

  deselect: ->
    @selected().removeClass('selected')
    @form.hide()

  update_period: (data) ->
    if @selected().hasClass('empty')
      @selected().closest('.cell').prepend(data)
      @selected().removeClass('selected')
    else
      @selected().parent().replaceWith(data)

  remove_period: ->
    @selected().remove()
    @format()
    @deselect()


class Form
  constructor: (table) ->
    @table = table

  container: -> $('div.period_form')
  form: -> @container().find('form')
  destroy_link: -> $('.destroy_link')

  update: (period) ->
    $.get period.attr('href'), (data) =>
      @show(data)
      @bindings()
      @place(period)
      @container().show()

  show: (data) ->
    @container().html(data).show()
    @container().find('select').chosen()

  place: (period) ->
    offset = period.offset()
    top = offset.top + period.height()
    left = offset.left - border_width

    @container().offset
      top: top
      left:left

  hide: ->
    @container().hide()

  bindings: ->
    @form().submit (e) =>
      $.post e.target.action, $(e.target).serialize(), (data) =>
        wrapperd_data = $('<div>' + data + '</div>')
        if $('form', wrapperd_data).size() > 0
          @show(data)
        if $('.period', wrapperd_data).size() > 0
          @table.update_period(data)
          @hide() 

        @bindings()
      return false

    @destroy_link().click (e) =>
      request = $.ajax 
        type: 'DELETE'
        url: e.target.href
      request.done =>
          @hide()
          @table.remove_period()
      return false


jQuery ->
  tab = new Tab()

  $('.tabs').tabs
    beforeLoad: (e, ui) ->
      unless tab.table? 
        tab.update(ui.ajaxSettings.url)
      e.preventDefault()

