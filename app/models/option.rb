class Option < ActiveRecord::Base
  has_paper_trail

  attr_accessible :question_id, :answer, :correct

  belongs_to :question

  validates :question_id, :answer, :correct, presence: true
  validates :answer, uniqueness: { scope: :question_id }

  before_validation :set_correctness

private

  def set_correctness
    self.correct ||= false
  end
end
  
