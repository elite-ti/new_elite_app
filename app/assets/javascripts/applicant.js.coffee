jQuery ->
  $('#applicant_super_klazz').parent().hide()
  super_klazzes = $('#applicant_super_klazz').html()
  console.log(super_klazzes)
  $('#applicant_exam_campus_id').change ->
    country = $('#applicant_exam_campus_id :selected').text()
    escaped_country = country.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(super_klazzes).filter("optgroup[label='#{escaped_country}']").html()
    if options
      $('#applicant_super_klazz').html(options)
      $('#applicant_super_klazz').parent().show()      
    else
      $('#applicant_super_klazz').empty()
      $('#applicant_super_klazz').parent().hide()