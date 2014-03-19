jQuery ->
  $('#save_button_exam_execution').click ->
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
    result += "<Row><Cell ss:StyleID=\"xlHeader\" ss:MergeAcross=\"" + ($("#results").contents("thead").contents("tr").contents("th").length - 1) + "\"><Data ss:Type=\"String\">" + $(".klazz_name_exam_execution").text().split(" • ")[0] + "</Data></Cell></Row>"
    result += "<Row><Cell ss:StyleID=\"xlHeader\" ss:MergeAcross=\"" + ($("#results").contents("thead").contents("tr").contents("th").length - 1) + "\"><Data ss:Type=\"String\">" + $(".klazz_name_exam_execution").text().split(" • ")[2] + "</Data></Cell></Row>"
    result += "<Row><Cell ss:StyleID=\"xlHeader\" ss:MergeAcross=\"" + ($("#results").contents("thead").contents("tr").contents("th").length - 1) + "\"><Data ss:Type=\"String\">" + $(".klazz_name_exam_execution").text().split(" • ")[1] + "</Data></Cell></Row><Row>"
    i = 0
    while i < $("#results").contents("thead").contents("tr").contents("th").length
      result += "<Cell ss:StyleID=\"xlTitle\"><Data ss:Type=\"String\">" + $.map($("#results").contents("thead").contents("tr").contents("th"), jQuery.text)[i] + "</Data></Cell>"
      i++
    i = 0
    console.log($("#results").contents("tbody").contents("tr").length)
    while i < $("#results").contents("tbody").contents("tr").length
      result += "</Row><Row>"
      j = 0
      while j < $("#results").contents("tbody").contents("tr").eq(i).contents("td").length
        type = "Number" 
        type = "String" if j == 1 || j == 2
        text = $.map($.map($("#results").contents("tbody").contents("tr").eq(i).contents("td"), jQuery.text), jQuery.trim)[j]
        result += "<Cell ss:StyleID=\"xlBody\"><Data ss:Type=\"" + type + "\">" + text + "</Data></Cell>"
        j++
      i++
    result += "</Row></Table></Worksheet></Workbook>"    
    data_type = "data:application/vnd.ms-excel"
    table_div = document.getElementById("results")
    table_html = result.replace(RegExp(" ", "g"), "%20")
    a.href = data_type + ", " + table_html

    #setting the file name
    a.download = "ExamResult_" + $('.klazz_name_exam_execution').text().replace(RegExp(" • ", "g"), "_") + "_" + postfix + ".xls"

    #triggering the function
    a.click()
    return false

  $('#exam_execution_exam_shift__-_').attr('checked', true)

  $('#exam_execution_all_campus').click ->
    if $('#exam_execution_all_campus').is(':checked') == true
      $('#exam_execution_campus_ids option').prop('selected', true)
      $('select').not('#select_roles').chosen()
      $('select').trigger('liszt:updated')
    if $('#exam_execution_all_campus').is(':checked') == false
      $('#exam_execution_campus_ids option').prop('selected', false)
      $('select').not('#select_roles').chosen()
      $('select').trigger('liszt:updated')

  $('.new_exam_execution').submit ->
    $('.error').remove()
    submit = true
    if $(this).find('#exam_execution_exam_name').val() == ''
      $('#exam_execution_exam_name').closest('.input').append('<span class="error" style="display:inline;margin-left:10px;">Preencha esse campo</span>')
      submit = false
    if $(this).find('#exam_execution_datetime').val() == ''
      $('#exam_execution_datetime').closest('.input').append('<span class="error">Preencha esse campo</span>')
      submit = false
    if $(this).find('#exam_execution_exam_cycle').val() == '' 
      $('#exam_execution_exam_cycle').closest('.input').append('<span class="error">Preencha esse campo</span>')
      submit = false
    if $(this).find('#exam_execution_campus_ids').val() == null
      $('#exam_execution_campus_ids').closest('.input').append('<span class="error">Preencha esse campo</span>')
      submit = false
    if $(this).find('#exam_execution_product_year_ids').val() == null
      $('#exam_execution_product_year_ids').closest('.input').append('<span class="error">Preencha esse campo</span>')
      submit = false

    return submit