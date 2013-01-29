class CardType < ActiveRecord::Base
  has_paper_trail

  PERMITTED_CHARACTERS = %w[A B C D E Z W] + (0..9).to_a.map(&:to_s)
  RESULT_SIZE = 107
  
  attr_accessible :card, :name, :parameters, :student_number_length

  has_many :student_exams

  validates :card, :name, :parameters, presence: true
  validates :name, uniqueness: true

  mount_uploader :card, CardTypeUploader

  def is_valid_result?(result)
    correct_size?(result) && permitted_characters?(result)
  end

private

  def correct_size?(result)
    result.length == RESULT_SIZE
  end

  def permitted_characters?(result)
    result.each_char do |char|
      return false if not PERMITTED_CHARACTERS.include?(char)
    end
    true
  end
end
