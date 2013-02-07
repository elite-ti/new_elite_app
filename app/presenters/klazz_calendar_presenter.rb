class KlazzCalendarPresenter < BasePresenter
  presents :klazz_calendar
  delegate :monday, :klazz, :week, :klazz_periods, to: :klazz_calendar

  def next_week_url
    dated_url monday.next_week
  end

  def prev_week_url
    dated_url monday.prev_week
  end

  def base_url
    h.klazz_calendar_path(klazz) 
  end

  def empty_klazz_period(date, position)
    h.link_to(new_klazz_period_path(date, position)) do 
      h.tag(:div, class: 'klazz_period empty')
    end.html_safe
  end

private 

  def new_klazz_period_path(date, position)
    h.new_klazz_calendar_path(date: date, position: position, klazz_id: klazz.id)
  end

  def dated_url(date)
    base_url + '?date=' + date.strftime('%Y-%m-%d')
  end
end