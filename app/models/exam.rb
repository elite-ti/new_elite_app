class Exam < ActiveRecord::Base
  attr_accessible :date, :exam_cycle_id, :name

  belongs_to :exam_cycle

  validates :date, :name, :exam_cycle_id, presence: true
  validates :name, uniqueness: { scope: :exam_cycle_id }
end
