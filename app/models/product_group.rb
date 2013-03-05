class ProductGroup < ActiveRecord::Base
  attr_accessible :name

  has_many :products
  has_many :product_group_preferences
  has_many :teachers_with_preference, through: :product_group_preferences, source: :teacher

  validates :name, presence: true, uniqueness: true
end
