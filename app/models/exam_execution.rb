#encoding: utf-8

class ExamExecution < ActiveRecord::Base

  attr_accessible :exam_cycle_id, :super_klazz_id, :exam_id, :datetime
  delegate :is_bolsao, to: :exam_cycle

  belongs_to :exam_cycle
  belongs_to :super_klazz
  belongs_to :exam
  has_many :student_exams
  has_many :card_processings

  validates :exam_cycle, :super_klazz, :exam, presence: :true 

  def name
    exam_cycle.name + ' - ' + super_klazz.name + ' - ' + exam.exam_questions.size.to_s + ' questions'
  end

  def full_name
    super_klazz.campus.name + ' - ' + datetime.strftime('%d/%m') + ' - ' + exam_cycle.name
  end

  def number_of_enrolled_students
    super_klazz.enrolled_students.size
  end

  def total_number_of_cards
    (card_processings.map(&:student_exams).flatten + student_exams).uniq.size
  end

  def all_student_exams
    card_processing_ids = card_processings.map(&:id).join(',')
    if card_processing_ids.present?
      @all_student_exams = @all_student_exams || StudentExam.where("card_processing_id in (#{card_processing_ids}) or exam_execution_id = #{id}")
    else
      @all_student_exams = @all_student_exams || StudentExam.where("exam_execution_id = #{id}")
    end
      # (card_processings.map(&:student_exams).flatten + student_exams).uniq
  end

  def number_of_errors
    all_student_exams.select{|se| (StudentExam::NEEDS_CHECK).include?(se.status)}.size
  end

  def needs_check?
    all_student_exams.select{|se| (StudentExam::NEEDS_CHECK).include?(se.status) }.any?
    # student_exams.needing_check.any?
  end

  def to_be_checked
    all_student_exams.select{|se| (StudentExam::NEEDS_CHECK).include?(se.status) }.first
    # student_exams.needing_check.first
  end
end 