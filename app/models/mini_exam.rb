class MiniExam < ActiveRecord::Base
  attr_accessible :correct_answers, :exam_id, :options_per_question, :subject_id, :order

  belongs_to :exam
  belongs_to :subject
  has_many :exam_questions

  validates :exam_id, :correct_answers, :options_per_question, :subject_id, :order, presence: true

  after_create :create_questions

  def answers_string
    MiniExam.where(exam_id: exam_id, order: [1,order-1]).map(&:correct_answers)*""
  end

  def first_question
    answers_string.size + 1
  end

  def last_question
    first_question + correct_answers.size - 1
  end

private
  def create_questions
    question_ids = ExamQuestion.where(exam_id: exam_id, number: first_question..last_question).map(&:question).map(&:id)
    subject = Subject.find(subject_id)
    subject_topic = Topic.where(subject_id: subject.id).first_or_create!(name: subject.name, subtopics: 'All', subject_id: subject.id)    
    question_ids.each do |question|
      QuestionTopic.create!(
        question_id: question,
        topic_id: subject_topic.id)
    end
  end
end














