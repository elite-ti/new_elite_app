class KlazzCalendar
  attr_reader :klazz, :week, :monday

  def initialize(klazz_id, date)
    @klazz = Klazz.find(klazz_id)
    @monday = (date ? Date.parse(date) : Date.current).beginning_of_week
    @week = @monday..(@monday + 5.days)
  end

  def klazz_periods(date, position)
    cached_klazz_periods.select do |klazz_period|
      klazz_period.date == date && klazz_period.position == position
    end
  end

private

  def cached_klazz_periods
    @cached_klazz_periods ||= @klazz.klazz_periods.
      includes({ teaching_assignment: [:subject, :teacher] }).where(date: @week)
  end
end