class KlazzCalendarPresenter < CalendarPresenter
  attr_reader :klazz

  def initialize(klazz, week, template)
    @klazz = klazz
    super(week, template)
  end

  def base_url
    h.klazz_periods_path(klazz) 
  end

  def csv
    CSV.generate do |csv|
      csv << ['Klazz:', klazz.name]
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
    @periods_of_week ||= super.where(klazz_id: klazz.id)
  end

  def formatted_period(date, position)
    periods(date, position).map do |period|
      period.teacher.nickname + ' - ' + period.subject.code + "\n"
    end.chomp
  end
end