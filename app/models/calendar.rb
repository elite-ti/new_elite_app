class Calendar < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :date, :klazz_id

  belongs_to :klazz
  has_many :time_tables, dependent: :destroy
  accepts_nested_attributes_for :time_tables

  validates :date, :klazz_id, presence: true
  validates :date, uniqueness: { scope: :klazz_id }

  def find_time_tables_by_position(i)
    time_tables.map do |time_table|
      time_table.position == i ? time_table : nil
    end.compact
  end

  def self.weekly(date)
    date = date.beginning_of_week
    calendars = includes(time_tables: {teaching_assignment: [:teacher, :subject]}).order('date asc')
    calendars.where('date >= ? and date < ?', date, date.next_week)
  end
end
