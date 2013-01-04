module TimetableHelper
  def color(time_table)
    return 'red' if time_table.teacher_absence
    return 'green' if time_table.past?
    return 'yellow' if time_table.future?
    nil
  end
end