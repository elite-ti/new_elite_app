show_back_button = () ->
  $('.klazz_name').show()
  $('.loading').show()
  $('#back_button').show()
  $('#save_button').show()
  $('.form-inputs').hide()
  $('.form-actions').hide()
  $('.label_div').hide()

hide_back_button = () ->
  $('.klazz_name').hide()
  $('.loading').hide()
  $('#back_button').hide()
  $('#save_button').hide()  
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
  $('#save_button').click ->
    #getting values of current time for generating the file name
    dt = new Date()
    day = dt.getDate()
    month = dt.getMonth() + 1
    year = dt.getFullYear()
    hour = dt.getHours()
    mins = dt.getMinutes()
    postfix = year + month + day + "_" + hour + mins

    #creating a temporary HTML link element (they support setting file names)
    a = document.createElement("a")

    #getting data from our div that contains the HTML table
    result = "<?xml version=\"1.0\"?><Workbook xmlns=\"urn:schemas-microsoft-com:office:spreadsheet\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:x=\"urn:schemas-microsoft-com:office:excel\" xmlns:ss=\"urn:schemas-microsoft-com:office:spreadsheet\" xmlns:html=\"http://www.w3.org/TR/REC-html40\">"
    result += "<ss:Styles><ss:Style ss:ID=\"xlHeader\" ss:Name=\"Klazz\"><ss:Alignment ss:Horizontal=\"Center\"/><ss:Font ss:Size=\"20\" ss:Bold=\"1\" ss:FontName=\"Verdana\"/></ss:Style><ss:Style ss:ID=\"xlTitle\" ss:Name=\"Normal\"><ss:Alignment ss:Horizontal=\"Center\"/><ss:Borders><ss:Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" /><ss:Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" /><ss:Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" /><ss:Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" /></ss:Borders><ss:Interior ss:Color=\"#A3A3A3\" ss:Pattern=\"Solid\" /><ss:Font ss:Size=\"10\" ss:Bold=\"1\" ss:FontName=\"Verdana\"/></ss:Style><ss:Style ss:ID=\"xlBody\" ss:Name=\"Content\"><ss:Alignment ss:Horizontal=\"Center\"/><ss:Borders><ss:Border ss:Position=\"Bottom\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" /><ss:Border ss:Position=\"Left\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" /><ss:Border ss:Position=\"Right\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" /><ss:Border ss:Position=\"Top\" ss:LineStyle=\"Continuous\" ss:Weight=\"1\" /></ss:Borders><ss:Font ss:Size=\"10\" ss:Bold=\"0\" ss:FontName=\"Verdana\"/></ss:Style></ss:Styles>"
    result += "<Worksheet ss:Name=\"" + "Sheet1" + "\"><Table>"
    result += "<Row><Cell ss:StyleID=\"xlHeader\" ss:MergeAcross=\"" + ($("#exam_results").contents().first().contents().first().contents().length - 1) + "\"><Data ss:Type=\"String\">" + $(".klazz_name").text().split("  •  ")[0] + "</Data></Cell></Row>"
    result += "<Row><Cell ss:StyleID=\"xlHeader\" ss:MergeAcross=\"" + ($("#exam_results").contents().first().contents().first().contents().length - 1) + "\"><Data ss:Type=\"String\">" + $(".klazz_name").text().split("  •  ")[2] + "</Data></Cell></Row>"
    result += "<Row><Cell ss:StyleID=\"xlHeader\" ss:MergeAcross=\"" + ($("#exam_results").contents().first().contents().first().contents().length - 1) + "\"><Data ss:Type=\"String\">" + $(".klazz_name").text().split("  •  ")[1] + "</Data></Cell></Row><Row>"
    i = 0
    while i < $("#exam_results").contents().first().contents().first().contents().length
      result += "<Cell ss:StyleID=\"xlTitle\"><Data ss:Type=\"String\">" + $.map($("#exam_results").contents().first().contents().first().contents(), jQuery.text)[i] + "</Data></Cell>"
      i++
    i = 0
    console.log($("#exam_results").contents().last().contents().length)
    while i < $("#exam_results").contents().last().contents().length
      result += "</Row><Row>"
      j = 0
      while j < $("#exam_results").contents().last().contents().eq(i).contents().length
        type = "Number" 
        type = "String" if j == 1 || j == 2
        text = $.map($("#exam_results").contents().last().contents().eq(i).contents(), jQuery.text)[j]
        text = text.toUpperCase();
        result += "<Cell ss:StyleID=\"xlBody\"><Data ss:Type=\"" + type + "\">" + text + "</Data></Cell>"
        j++
      i++
    result += "</Row></Table></Worksheet></Workbook>"    
    data_type = "data:application/vnd.ms-excel"
    table_div = document.getElementById("exam_results")
    table_html = result.replace(RegExp(" ", "g"), "%20")
    a.href = data_type + ", " + table_html

    #setting the file name
    a.download = "ExamResult_" + $('.klazz_name').text().replace(RegExp("  •  ", "g"), "_") + "_" + postfix + ".xls"

    #triggering the function
    a.click()
    return false
