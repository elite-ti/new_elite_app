class QuestionTopic < ActiveRecord::Base

  attr_accessible :question_id, :topic_id

  belongs_to :question, inverse_of: :question_topics
  belongs_to :topic

  validates :question, :topic, presence: true
  validates :question_id, uniqueness: { scope: :topic_id }
end