class TeacherCalendarPresenter < CalendarPresenter
  attr_reader :teacher

  def initialize(teacher, week, template)
    @teacher = teacher
    super(week, template)
  end

  def base_url
    h.teacher_periods_path(teacher) 
  end

  def csv
    CSV.generate do |csv|
      csv << ['Teacher:', teacher.nickname]
      csv << @week
      time_array.each do |time|
        line = []
        line = [time] + @week.each do |date|
          formatted_periods(date, position)
        end
        csv << line
      end
    end
  end

private 

  def periods_of_week
    @periods_of_week ||= super.where(teacher_id: teacher.id)
  end

  def formatted_period(date, position)
    periods(date, position).map do |period|
      period.klazz.name + ' - ' + period.subject.code + "\n"
    end.chomp
  end
end