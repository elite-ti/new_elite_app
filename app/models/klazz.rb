class Klazz < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :campus_id, :year_id, :name

  default_scope order('name')

  belongs_to :campus
  belongs_to :year

  has_many :ticks, dependent: :destroy
  has_many :topics, through: :ticks

  has_many :teaching_assignments, dependent: :destroy
  has_many :time_tables, through: :teaching_assignments
  has_many :teacher_absences, through: :time_tables
  has_many :teachers, through: :teaching_assignments
  has_many :subjects, through: :teaching_assignments

  validates :campus_id, :name, :year_id, presence: true
  validates :name, uniqueness: true

  def find_time_tables_by_date_and_position(date, position)
    time_tables_by_date(date).select { |time_table| time_table.position == position }
  end

  def time_tables_by_date(date)
    @time_tables_by_date ||= Hash.new do |hash, key|
      hash[key] = find_time_tables_by_date(*key)
    end
    @time_tables_by_date[date]
  end

private

  def find_time_tables_by_date(date)
    time_tables.includes({teaching_assignment: [:subject, :teacher]}).order('date asc').where(date: date)
  end
end
