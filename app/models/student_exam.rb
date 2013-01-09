class StudentExam < ActiveRecord::Base
  attr_accessible :card, :exam_id, :student_id
  attr_accessor :card_data

  belongs_to :exam
  belongs_to :student

  validates :card, :exam_id, :student_id, presence: true
  validates :exam_id, uniqueness: { scope: :student_id }

  mount_uploader :card, StudentExamCardUploader

  before_validation :scan_card
  before_save :create_exam_answers

private

  def scan_card
    # run card_reader and save data in card_data attribute
  end

  def create_exam_answers
    # create exam_answers via card data
  end
end
