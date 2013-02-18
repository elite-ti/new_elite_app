class SubjectThread < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :subject_id, :product_year_id, :topic_ids

  belongs_to :subject
  belongs_to :product_year

  has_many :subject_thread_topics, dependent: :destroy, inverse_of: :subject_thread
  has_many :topics, through: :subject_thread_topics


  validates :name, :subject_id, :product_year_id, presence: true
  validates :name, uniqueness: { scope: [:subject_id, :product_year_id] }
  validate :topics_belong_to_subject

private

  def topics_belong_to_subject
    if (topics.map(&:subject).uniq - [subject]).any?
      errors.add(:topic_ids, 'must belong to subject')
    end
  end
end
