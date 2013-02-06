class Klazz < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :campus_id, :year_id, :name

  belongs_to :campus
  belongs_to :year

  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  has_many :ticks, dependent: :destroy
  has_many :topics, through: :ticks

  has_many :teaching_assignments, dependent: :destroy
  has_many :klazz_periods, through: :teaching_assignments
  has_many :teacher_absences, through: :klazz_periods
  has_many :teachers, through: :teaching_assignments
  has_many :subjects, through: :teaching_assignments

  validates :campus_id, :name, :year_id, presence: true
  validates :name, uniqueness: true

  default_scope order('name')

  def find_klazz_periods_by_date_and_position(date, position)
    klazz_periods_by_date(date).select { |klazz_period| klazz_period.position == position }
  end

  def klazz_periods_by_date(date)
    @klazz_periods_by_date ||= Hash.new do |hash, key|
      hash[key] = find_klazz_periods_by_date(*key)
    end
    @klazz_periods_by_date[date]
  end

private

  def find_klazz_periods_by_date(date)
    klazz_periods.includes({ teaching_assignment: [:subject, :teacher] }).
      order('date asc').where(date: date)
  end
end
