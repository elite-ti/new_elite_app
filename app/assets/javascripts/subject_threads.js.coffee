class SubjectSelect
  constructor: (id) ->
    @id = id

  self: ->
    $(@id)

  selected_subject: -> 
    @self().find(':selected').text()

class TopicSelect
  constructor: (id) ->
    @id = id
    @data = $(@self().html())

  self: -> 
    $(@id)

  update: (selected_subject) ->
    options = @filter(selected_subject)
    if options
      @self().html(options)
      @self().parent().show()
      @self().trigger("liszt:updated")
    else
      @self().empty()
      @self().parent().hide()

  filter: (selected_subject) ->
    selected_subject = selected_subject.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    @data.filter("optgroup[label='#{selected_subject}']").html()

class SubjectThread
  constructor: (subject_id, topics_id) ->
    @subject_select = new SubjectSelect(subject_id)
    @topic_select = new TopicSelect(topics_id)
    @bind_events()

  bind_events: ->
    @topic_select.update(@subject_select.selected_subject())

    @subject_select.self().change =>
      @topic_select.update(@subject_select.selected_subject()) 
      

jQuery ->
  new SubjectThread('#subject_thread_subject_id', '#subject_thread_topic_ids')
