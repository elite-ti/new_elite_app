class ExamCycle < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :end_date, :name, :start_date, :year_id, :is_bolsao

  belongs_to :year

  validates :name, :year_id, presence: true
  validates :name, uniqueness: { scope: :year_id }
end
