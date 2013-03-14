class ExamCycleSelect
  constructor: (id) ->
    @id = id

  self: ->
    $(@id)

  selected_exam_cycle: -> 
    @self().find(':selected').text()

class SuperKlazzSelect
  constructor: (id) ->
    @id = id
    @data = $(@self().html())

  self: -> 
    $(@id)

  update: (selected_exam_cycle) ->
    options = @filter(selected_exam_cycle)
    if options
      @self().html(options)
      @self().parent().show()
      @self().trigger("liszt:updated")
    else
      @self().empty()
      @self().parent().hide()

  filter: (selected_exam_cycle) ->
    selected_exam_cycle = selected_exam_cycle.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    @data.filter("optgroup[label='#{selected_exam_cycle}']").html()

class ExamDayForm
  constructor: (exam_cycle_id, super_klazz_ids) ->
    @exam_cycle_select = new ExamCycleSelect(exam_cycle_id)
    @super_klazz_select = new SuperKlazzSelect(super_klazz_ids)
    @bind_events()

  bind_events: ->
    @super_klazz_select.update(@exam_cycle_select.selected_exam_cycle())

    @exam_cycle_select.self().change =>
      @super_klazz_select.update(@exam_cycle_select.selected_exam_cycle()) 
      

jQuery ->
  new ExamDayForm('#exam_day_form_exam_cycle_id', '#exam_day_form_super_klazz_ids')
