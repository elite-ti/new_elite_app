class CalendarPresenter
  attr_reader :klazz, :week, :monday

  def initialize(klazz, week, template)
    @klazz = klazz
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
    h.klazz_periods_path(klazz) 
  end

  def time_array
    Period.time_array
  end

  def empty_period(date, position)
    path = h.new_klazz_period_path(
      klazz_id: klazz.id, 
      period: { date: date, position: position })

    h.link_to(path) do 
      h.tag(:div, class: 'period empty')
    end.html_safe
  end

  def periods(date, position)
    periods_of_week.select do |period|
      period.date == date && period.position == position
    end
  end

private 

  def periods_of_week
    @periods_of_week ||= Period.includes(:teacher, :subject_thread).
      where(klazz_id: klazz.id, date: week)
  end

  def dated_url(date)
    base_url + '?date=' + date.strftime('%Y-%m-%d')
  end

  def h
    @template
  end
end