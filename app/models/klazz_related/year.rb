class Year < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :product_id, :year_number

  belongs_to :product
  has_many :klazzes, dependent: :destroy
  has_many :exam_cycles, dependent: :destroy
  has_many :subject_threads, dependent: :destroy
  
  validates :product_id, :name, presence: true
  validates :name, uniqueness: { scope: :product_id }
end
