class Topic < ActiveRecord::Base
  has_paper_trail

  attr_accessible :itens, :name, :subject_id

  belongs_to :subject

  has_many :subject_thread_topics, dependent: :destroy
  has_many :subject_threads, through: :subject_thread_topics

  has_many :question_topics, dependent: :destroy
  has_many :questions, through: :question_topics

  validates :name, :itens, :subject_id, presence: true
end
