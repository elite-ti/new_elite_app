class KlazzCalendar
  attr_reader :klazz, :week, :monday

  def initialize(klazz_id)
    @klazz = Klazz.find(klazz_id)
  end

  def periods_of_week(week)
    @klazz.periods.
      includes({ teaching_assignment: [:subject, :teacher] }).
      where(date: week)
  end

  def new_period(date, position)
    Period.new(klazz_id: klazz.id, date: date, position: position)
  end
end