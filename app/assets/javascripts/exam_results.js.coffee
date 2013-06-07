show_back_button = () ->
  $('.klazz_name').show()
  $('.loading').show()
  $('#back_button').show()
  $('.form-inputs').hide()
  $('.form-actions').hide()
  $('.label_div').hide()

hide_back_button = () ->
  $('.klazz_name').hide()
  $('.loading').hide()
  $('#back_button').hide()
  $('.form-inputs').show()
  $('.form-actions').show()
  $('.label_div').show()

destroy_table = () ->
  for table in $.fn.dataTable.fnTables(true)
    $(table).dataTable().fnDestroy()
  $('table').remove()

table_header = (content_array) ->
  result = ''
  for content in content_array
    result += '<th>' + content + '</th>'
  result

create_table = (array) ->
  $('.table_div').append("<table id='exam_results' class='display'><thead><tr>" + table_header(array) + "</tr></thead><tbody></tbody></table>")
  $('.loading').hide()

table_cell = (content_array) ->
  result = ''
  for property of content_array
    result += '<td>' + content_array[property] + '</td>'
  result

table_row = (array) ->
  '<tr>' + table_cell(array) + '</tr>'

show_exam_results = (data) ->
  console.log('Inside show_exam_results')
  destroy_table()
  create_table(Object.keys(data[0]))
  tbody = $('table').find('tbody')

  for row in tbody.find('tr')
    row.remove()

  for exam_result in data
    tbody.append(table_row(exam_result))

  $('table').dataTable
    sPaginationType: 'full_numbers'
    bJQueryUI: true
    bPaginate: false
    aaSorting: [[ Object.keys(data[0]).length - 1, "desc" ]]


jQuery ->
    hide_back_button()

jQuery ->
  $('.remote').click ->
    $('.klazz_name').show()
    $('.loading').show()
    $('.klazz_name').html($('#exam_result_product_year_id_chzn span').text() + '  •  ' + $('#exam_result_campus_id_chzn span').text() + '  •  ' + $('#exam_result_date_chzn span').text())
    show_back_button()
    form = $(this).closest('form')
    console.log('calling GET')
    $.get form.attr('action'), form.serialize(), show_exam_results, 'json'
    return false

jQuery ->
  $('#back_button').click ->
    destroy_table()
    hide_back_button()
    return false
