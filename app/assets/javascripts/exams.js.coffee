class SubjectSelect
  constructor: (id) ->
    @id = id

  self: ->
    $(@id)

  selected: -> 
    @selected_subjects = ($(selected_subject).text() for selected_subject in @self().find(':selected'))

class TopicSelect
  constructor: (id) ->
    @id = id
    @data = $(@self().html())

  self: -> 
    $(@id)

  update: (selected_subjects) ->
    options = @available_options(selected_subjects) 
    if options
      @self().html(options)
      @self().parent().show()
      @self().trigger("liszt:updated")
    else
      @self().empty()
      @self().parent().hide()

  available_options: (selected_subjects) ->
    (@filter(selected_subject) for selected_subject in selected_subjects).join('\n')

  filter: (selected_subject) ->
    selected_subject = selected_subject.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    @data.filter("optgroup[label='#{selected_subject}']").html()

class ExamForm
  constructor: (subject_id, topics_id) ->
    @subject_select = new SubjectSelect(subject_id)
    @topic_select = new TopicSelect(topics_id)
    @bind_events()

  bind_events: ->
    @topic_select.update(@subject_select.selected())

    @subject_select.self().change =>
      @topic_select.update(@subject_select.selected()) 
      

jQuery ->
  exam_form = new ExamForm('#exam_subject_ids', '#exam_question_ids')
