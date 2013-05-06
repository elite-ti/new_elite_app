class SubjectThreadTopic < ActiveRecord::Base

  attr_accessible :subject_thread_id, :topic_id, :weight

  belongs_to :subject_thread, inverse_of: :subject_thread_topics
  belongs_to :topic

  validates :subject_thread, :topic, presence: true
  validates :subject_thread_id, uniqueness: { scope: :topic_id }
end
