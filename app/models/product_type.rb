class ProductType < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :name

  has_many :products, dependent: :destroy
  
  validates :name, presence: true, uniqueness: true
end
