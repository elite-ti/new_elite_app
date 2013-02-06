module TimetableHelper
  def color(klazz_period)
    return 'red' if klazz_period.teacher_absence
    return 'green' if klazz_period.past?
    return 'yellow' if klazz_period.future?
    nil
  end
end