class PollAnswer < ActiveRecord::Base
  attr_accessible :grade, :poll_question_id

  belongs_to :poll_question, dependent: :destroy

  validates :grade, :poll_question_id, presence: true
end
