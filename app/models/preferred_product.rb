class PreferredProduct < ActiveRecord::Base
  has_paper_trail

  attr_accessible :preference, :product_id, :teacher_id

  belongs_to :product
  belongs_to :teacher

  validates :product_id, :teacher_id, presence: true
  validates :product_id, uniqueness: { scope: :teacher_id }
end
