jQuery ->
  $('#subject_thread_topic_ids').parent().hide()
  topics = $('#subject_thread_topic_ids').html()
  $('#subject_thread_subject_id').change ->
    subject = $('#subject_thread_subject_id :selected').text()
    escaped_subject = subject.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(topics).filter("optgroup[label='#{escaped_subject}']").html()
    if options
      $('#subject_thread_topic_ids').html(options)
      $('#subject_thread_topic_ids').parent().show()
      $('#subject_thread_topic_ids').trigger("liszt:updated")
    else
      $('#subject_thread_topic_ids').empty()
      $('#subject_thread_topic_ids').parent().hide()
