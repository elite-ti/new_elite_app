class SubjectThread < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :subject_id, :year_id

  belongs_to :subject
  belongs_to :year

  validates :name, :subject_id, :year_id, presence: true
  validates :name, uniqueness: { scope: [:subject_id, :year_id] }
end
