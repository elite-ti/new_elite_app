toggle_ok = (checkboxes = $('.excused')) ->
	for checkbox in checkboxes
		ok = $(checkbox).parent().find('.ok')
		if $(checkbox).attr('checked') == 'checked' then ok.show() else ok.hide()

value = (checkbox) ->
	if checkbox.attr('checked') == 'checked' then return 'true' else return 'false'

blink_color = (checkbox) ->
  if checkbox.attr('checked') == 'checked' then return '#65FD67' else return '#FD6565'

blink_row = (row, new_color) ->
	blink_tag(row, new_color)
	blink_tag(row.find('.sorting_1'), new_color)

blink_tag = (tag, new_color) ->
	old_color = tag.css('background-color')
	tag.animate('background-color' : new_color, 500).animate('background-color' : old_color)

jQuery ->
	if $('#teacher_absences').size() != 0 
		$('#teacher_absences').dataTable().fnSort([[1,'desc']])

	toggle_ok()

	$('.excused').click ->
		checkbox = $(this)
		request = $.ajax
			url: '/teacher_absences/' + checkbox.data('id')
			type: 'PUT'
			dataType: 'script'
			data: {'teacher_absence' : {'excused': value(checkbox)}}
		request.done ->
			blink_row checkbox.parent().parent(), blink_color(checkbox)
			toggle_ok checkbox

