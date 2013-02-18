class ProductPrincipal < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :employee_id, :product_id

  validates :employee_id, :product_id, presence: true
  validates :employee_id, uniqueness: true

  def accessible_klazz_ids
    product.campuses.map(&:klazzes).flatten.map(&:id)
  end
end
