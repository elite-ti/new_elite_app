class SubjectThreadTopic < ActiveRecord::Base
  has_paper_trail

  attr_accessible :subject_thread_id, :topic_id, :weight

  belongs_to :subject_thread
  belongs_to :topic

  validates :subject_thread_id, :topic_id, :weight, presence: true
  validates :subject_thread_id, uniqueness: { scope: :topic_id }
end
