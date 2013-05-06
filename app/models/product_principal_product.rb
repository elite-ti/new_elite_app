class ProductPrincipalProduct < ActiveRecord::Base
  
  attr_accessible :product_principal_id, :product_id

  belongs_to :product_principal, inverse_of: :product_principal_products
  belongs_to :product

  validates :product_principal, :product, presence: true
  validates :product_principal_id, uniqueness: { scope: :product_id }
end
