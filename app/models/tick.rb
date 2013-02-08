class Tick < ActiveRecord::Base
  has_paper_trail

  attr_accessible :period_id, :subject_thread_topic_id

  belongs_to :period
  belongs_to :subject_thread_topic_id

  validates :period_id, :subject_thread_topic_id, presence: true
end