border_width = 1
empty_period_width = 20
    
format_table = () ->
  for cell in $('.cell')
    filled_periods = $(cell).find('.filled')
    number_of_filled = filled_periods.size()
    if number_of_filled == 0
      $(cell).find('.empty').width($(cell).width() + border_width)
    else
      width = ($(cell).width() - empty_period_width)/number_of_filled - border_width
      $(filled).width(width) for filled in filled_periods 
      $(cell).find('.empty').width(empty_period_width + border_width)

update_calendar_tab = (url) ->
  $.get url, (data) ->
    $('#calendar_tab').html(data)
    format_table()  
    bindings()

bindings = () ->
  $('#date').datepicker
    dateFormat: 'dd/mm/yy'

  $('#date').change ->
    url = $(this).closest('form').attr('action') + '?date=' + this.value
    update_calendar_tab(url)

  $('.navigation a').click ->
    update_calendar_tab(this.href)
    return false

  $('.cell a').click ->
    $('.selected').removeClass('selected')
    $(this).find('.period').addClass('selected')
    update_form(this.href)
    return false

update_form = (url) ->
  $.get url, (data) ->
    $('.period_form').html(data).show()
    $('.period_form select').chosen()

    offset = $('.selected').offset()
    $('.period_form').offset
      top: offset.top + $('.selected').height()
      left: offset.left - border_width

    form_bindings()

form_bindings = () ->
  $('.period_form form').submit ->
    $.post this.action, $(this).serialize(), (data) ->
      if $('form', $('<div>' + data + '</div>')).size() > 0
        $('.period_form').html(data).show()
        $('.period_form select').chosen()
        form_bindings()
      if $('.period', $('<div>' + data + '</div>')).size() > 0
        if $('.selected').hasClass('empty')
          $('.selected').closest('.cell').prepend(data)
          $('.selected').removeClass('selected')
        else
          $('.selected').parent().replaceWith(data)
        format_table()
        bindings()
        $('.period_form').hide()
    return false


jQuery ->
  $('.tabs').tabs
    beforeLoad: (e, ui) ->
      if $('.calendar').size() > 0
        e.preventDefault()
    load: (e, ui) -> 
      format_table() 
      bindings()
