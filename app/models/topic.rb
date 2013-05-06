class Topic < ActiveRecord::Base

  attr_accessible :subtopics, :name, :subject_id

  belongs_to :subject

  has_many :subject_thread_topics, dependent: :destroy
  has_many :subject_threads, through: :subject_thread_topics

  has_many :question_topics, dependent: :destroy
  has_many :questions, through: :question_topics

  validates :name, :subtopics, :subject_id, presence: true
end
