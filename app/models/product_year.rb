class ProductYear < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name, :product_id, :year_id

  belongs_to :product
  belongs_to :year

  has_many :exam_cycles, dependent: :destroy
  has_many :subject_threads, dependent: :destroy
  has_many :super_klazzes, dependent: :destroy

  validates :product_id, :name, :year_id, presence: true
  validates :name, uniqueness: true 
end
