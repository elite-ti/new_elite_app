class Option < ActiveRecord::Base
  has_paper_trail

  attr_accessible :question_id, :answer, :correct, :letter

  belongs_to :question, inverse_of: :options

  validates :question, presence: true
  validates :answer, uniqueness: { scope: :question_id }

  before_validation :set_correctness
  after_save :set_letter
  after_destroy :set_letter

private

  def set_correctness
    self.correct ||= false
    nil
  end

  def set_letter
    letter = 'A'
    question.options.order('letter').each do |option|
      option.update_column :letter, letter 
      option.update_column :answer, 'Answer ' + letter
      letter.next!
    end
    nil
  end
end
  
