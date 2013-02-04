class Exam < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :formatted_datetime, :exam_cycle_id, :name, :subject_ids, :question_ids

  belongs_to :exam_cycle

  has_many :exam_subjects, dependent: :destroy, inverse_of: :exam
  has_many :subjects, through: :exam_subjects

  has_many :exam_questions, dependent: :destroy, inverse_of: :exam
  has_many :questions, through: :exam_questions

  has_many :student_exams, dependent: :destroy
  has_many :students, through: :student_exams

  validates :name, :exam_cycle_id, presence: true
  validates :name, uniqueness: { scope: :exam_cycle_id }

  def number_of_questions
    exam_questions.count
  end

  def formatted_datetime
    datetime.strftime('%a, %d/%m/%Y %H:%M')
  end

  def formatted_datetime=(_formatted_datetime)
    date, time = _formatted_datetime.to_s.split(', ').second.split(' ')
    day, month, year = date.split('/')
    hour, minute = time.split(':')
    self.datetime = Time.zone.parse("#{year}-#{month}-#{day} #{hour}:#{minute}:00")
  end
end
