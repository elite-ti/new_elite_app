class Answer < ActiveRecord::Base
  attr_accessible :grade, :question_id

  belongs_to :question, dependent: :destroy

  validates :grade, :question_id, presence: true
end
