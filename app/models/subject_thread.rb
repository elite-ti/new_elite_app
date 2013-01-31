class SubjectThread < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :subject_id, :year_id, :topic_ids

  belongs_to :subject
  belongs_to :year

  has_many :teaching_assignements
  has_many :klazzes, through: :teaching_assignments

  has_many :subject_thread_topics, dependent: :destroy
  has_many :topics, through: :subject_thread_topics


  validates :name, :subject_id, :year_id, presence: true
  validates :name, uniqueness: { scope: [:subject_id, :year_id] }
end
