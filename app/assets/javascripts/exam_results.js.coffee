destroy_table = () ->
  for table in $.fn.dataTable.fnTables(true)
    $(table).dataTable().fnDestroy()
  $('table').remove()


create_table = () ->
  $('form').append("<table id='exam_results' class='display'><thead><tr><th>RA</th>
    <th>Name</th><th>Grade</th></tr></thead><tbody></tbody></table>")

table_cell = (content) ->
  '<td>' + content + '</td>'

table_row = (ra, name, grade) ->
  '<tr>' + table_cell(ra) + table_cell(name) + table_cell(grade) + '</tr>'

show_exam_results = (data) ->
  destroy_table()
  create_table()
  tbody = $('table').find('tbody')

  for row in tbody.find('tr')
    row.remove()

  for exam_result in data
    tbody.append(table_row(exam_result['ra'], exam_result['name'], exam_result['grade']))

  $('table').dataTable
    sPaginationType: 'full_numbers'
    bJQueryUI: true


jQuery ->
  $('.remote').click ->
    form = $(this).closest('form')
    $.get form.attr('action'), form.serialize(), show_exam_results, 'json'

    return false