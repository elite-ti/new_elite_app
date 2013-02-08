class CalendarPresenter
  delegate :klazz, to: :klazz_calendar
  attr_reader :klazz_calendar, :week, :monday

  def initialize(klazz_calendar, week, template)
    @klazz_calendar = klazz_calendar
    @week = week
    @monday = @week.first
    @template = template
  end

  def next_week_url
    dated_url @monday.next_week
  end

  def prev_week_url
    dated_url @monday.prev_week
  end

  def base_url
    h.klazz_calendar_path(klazz) 
  end

  def time_array
    Period.time_array
  end

  def empty_period(date, position)
    path = h.new_klazz_calendar_path(date: date, position: position, klazz_id: klazz.id)
    h.link_to(path) do 
      h.tag(:div, class: 'period empty')
    end.html_safe
  end

  def periods(date, position)
    cached_periods_of_week.select do |period|
      period.date == date && period.position == position
    end
  end

private 

  def cached_periods_of_week
    @cached_periods_of_week ||= klazz_calendar.periods_of_week(week)
  end

  def dated_url(date)
    base_url + '?date=' + date.strftime('%Y-%m-%d')
  end

  def h
    @template
  end
end