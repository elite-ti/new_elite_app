class ExamCycle < ActiveRecord::Base
  attr_accessible :end_date, :name, :start_date, :year_id

  belongs_to :year

  validates :name, :year_id, presence: true
  validates :name, uniqueness: { scope: :year_id }
end
