class TeacherCalendarPresenter < CalendarPresenter
  attr_reader :teacher

  def initialize(teacher, week, template)
    @teacher = teacher
    super(week, template)
  end

  def base_url
    h.teacher_periods_path(teacher) 
  end

private 

  def periods_of_week
    @periods_of_week ||= super.where(teacher_id: teacher.id)
  end
end