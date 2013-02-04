class Question < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :stem, :model_answer, :topic_ids, :options_attributes

  has_many :exam_questions, dependent: :destroy
  has_many :exams, through: :exam_questions

  has_many :question_topics, dependent: :destroy, inverse_of: :question
  has_many :topics, through: :question_topics
  has_many :subjects, through: :topics

  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options,
    reject_if: :all_blank, allow_destroy: true

  validates :stem, :model_answer, presence: true
end
