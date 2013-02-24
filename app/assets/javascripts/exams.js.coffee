class Subexam
  constructor: (id) ->
    $('.template').clone().prepend($(e.target))
    

class ExamForm
  constructor: (subject_id, topics_id) ->
    @subexams = []
    @bind_events()

  bind_events: ->
    $('.add_subexam').click (e) =>
      @subexams << new Subexam(@subexams.size) 
      return false
      

jQuery ->
  exam_form = new ExamForm()
