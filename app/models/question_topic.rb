class QuestionTopic < ActiveRecord::Base
  has_paper_trail

  attr_accessible :question_id, :topic_id

  belongs_to :question
  belongs_to :topic

  validates :question_id, :topic_id, presence: true
  validates :question_id, uniqueness: { scope: :topic_id }
end