class Subject
  constructor: (id) ->
    @id = id

  form_select: ->
    $(@id)

  selected: -> 
    @form_select().find(':selected').text()    

class Topics
  constructor: (id) ->
    @id = id
    @data = $(@form_select().html())

  form_select: ->
    $(@id)    

  selected: -> 
    @form_select().find(':selected').text() 

  update: (selected_subject) ->
    options = @available_options(selected_subject)
    if options
      @form_select().html(options)
      @form_select().parent().show()
      @form_select().trigger("liszt:updated")
    else
      @form_select().empty()
      @form_select().parent().hide()

  available_options: (selected_subject) -> 
    escaped_selected_subject = selected_subject.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    @data.filter("optgroup[label='#{escaped_selected_subject}']").html()

class SubjectThread
  constructor: (subject_id, topics_id) ->
    @subject = new Subject(subject_id)
    @topics = new Topics(topics_id)
    @bind_events()

  bind_events: ->
    @topics.update(@subject.selected())

    @subject.form_select().change =>
      @topics.update(@subject.selected()) 
      

jQuery ->
  new SubjectThread('#subject_thread_subject_id', '#subject_thread_topic_ids')

  # $('#subject_thread_topic_ids').chosen().change ->
  #   topics = $('#subject_thread_topic_ids :selected').text()
    