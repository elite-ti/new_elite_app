class Tick < ActiveRecord::Base
  has_paper_trail

  attr_accessible :klazz_period_id, :subject_thread_topic_id

  belongs_to :klazz_period
  belongs_to :subject_thread_topic_id

  validates :klazz_period_id, :subject_thread_topic_id, presence: true
end