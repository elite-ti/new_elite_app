class ExamAnswer < ActiveRecord::Base
  has_paper_trail

  VALID_ANSWERS = %w[A B C D E]
  INVALID_ANSWERS = %w[Z W]
  ANSWERS = VALID_ANSWERS + INVALID_ANSWERS
  
  attr_accessible :answer, :exam_question_id, :student_exam_id, :needs_check

  belongs_to :exam_question
  belongs_to :student_exam

  validates :answer, :exam_question_id, :student_exam_id, presence: true
  validates :exam_question_id, uniqueness: { scope: :student_exam_id }

  before_create :set_needs_check

  def png_url
    path = png_path
    create_png unless File.exist?(png_path)
    path.split(File.join(Rails.root, 'public'))[1]
  end

private

  def set_needs_check
    debugger
    self.needs_check = !valid_answer?
    true
  end

  def valid_answer?
    VALID_ANSWERS.include?(answer) and not INVALID_ANSWERS.include?(answer)
  end

  def png_filename
    'question_' + exam_question.number.to_s + '.png'
  end

  def png_path
    File.join(File.dirname(student_exam.card.png.current_path), png_filename)
  end

  def create_png
    image = MiniMagick::Image.open(student_exam.card.png.current_path)

    question_number = exam_question.number
    width = 590
    height = 70
    x = question_number <= 50 ? 66 : 664
    y = 1038 + height*(question_number - 1)

    image.crop "#{width}x#{height}+#{x}+#{y}"
    image.resize '50%'
    image.write png_path
  end
end
