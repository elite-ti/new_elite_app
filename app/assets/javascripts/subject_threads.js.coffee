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

  update: (selected_subject) ->
    selected_subject = selected_subject.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = @data.filter("optgroup[label='#{selected_subject}']").html()
    if options
      @form_select().html(options)
      @form_select().parent().show()
      @form_select().trigger("liszt:updated")
    else
      @form_select().empty()
      @form_select().parent().hide()

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
