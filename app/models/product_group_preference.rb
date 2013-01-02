class ProductGroupPreference < ActiveRecord::Base
  attr_accessible :product_group_id, :teacher_id, :preference

  belongs_to :product_group
  belongs_to :teacher

  validates :product_group_id, presence: true
  validates :product_group_id, uniqueness: { scope: :teacher_id }
end
