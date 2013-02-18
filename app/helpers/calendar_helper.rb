module CalendarHelper
  def present_klazz_calendar(klazz, week)
    presenter = KlazzCalendarPresenter.new(klazz, week, self)
    yield presenter if block_given?
    presenter
  end

  def present_teacher_calendar(teacher, week)
    presenter = TeacherCalendarPresenter.new(teacher, week, self)
    yield presenter if block_given?
    presenter
  end
end