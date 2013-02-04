class SubjectSelect
  constructor: (id) ->
    @id = id

  self: ->
    $(@id)

  selected_subjects: -> 
    ($(selected_subject).text() for selected_subject in @self().find(':selected'))

class TopicSelect
  constructor: (id) ->
    @id = id
    @data = $(@self().html())

  self: -> 
    $(@id)

  update: (selected_subjects) ->
    values = @self().val()
    @data.replaceWith(@self().html())
    if options = @options(selected_subjects)
      @self().html(options)
      @self().val(values)
      @self().parent().show()
      @self().trigger("liszt:updated")
    else
      @self().empty()
      @self().parent().hide()

  options: (selected_subjects) ->
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
    @topic_select.update(@subject_select.selected_subjects())

    @subject_select.self().change =>
      @topic_select.update(@subject_select.selected_subjects()) 
      

jQuery ->
  exam_form = new ExamForm('#exam_subject_ids', '#exam_question_ids')
