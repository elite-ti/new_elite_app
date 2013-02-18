class KlazzCalendarPresenter < CalendarPresenter
  attr_reader :klazz

  def initialize(klazz, week, template)
    @klazz = klazz
    super(week, template)
  end

  def base_url
    h.klazz_periods_path(klazz) 
  end

private 

  def periods_of_week
    @periods_of_week ||= super.where(klazz_id: klazz.id)
  end
end