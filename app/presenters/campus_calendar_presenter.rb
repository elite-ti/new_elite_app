class CampusCalendarPresenter < CalendarPresenter
  attr_reader :campus

  def initialize(campus, week, template)
    @campus = campus
    super(week, template)
  end

  def base_url
    h.campus_periods_path(campus) 
  end

  def csv
    CSV.generate do |csv|
      csv << ['Teacher:', campus.name]
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
    @periods_of_week ||= super.where(klazz_id: campus.klazzes.map(&:id))
  end

  def formatted_period(date, position)
    periods(date, position).map do |period|
      period.klazz.name + ' - ' + period.subject.code + "\n"
    end.chomp
  end
end