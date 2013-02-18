class CalendarPresenter
   attr_reader :week, :monday

  def initialize(week, template)
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

  def empty_period(date, position)
    h.tag(:div, class: 'period empty')
  end

  def periods(date, position)
    periods_of_week.select do |period|
      period.date == date && period.position == position
    end
  end

  def time_array
    Period.time_array
  end

  def tag_classes(period)
    tag_classes = ''
    if period.past?
      tag_classes += ' past'
    else
      tag_classes += ' future'
    end
    tag_classes += ' absent' if period.absent?
    tag_classes
  end

protected 

  def periods_of_week
    Period.includes(:teacher, :subject, :klazz).where(date: week)
  end

  def dated_url(date)
    base_url + '?date=' + date.strftime('%Y-%m-%d')
  end

  def h
    @template
  end 
end