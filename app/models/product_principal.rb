class ProductPrincipal < ActiveRecord::Base
  
  attr_accessible :employee_id, :product_ids

  belongs_to :employee
  has_many :product_principal_products, dependent: :destroy, inverse_of: :product_principal
  has_many :products, through: :product_principal_products

  validates :employee_id, presence: true, uniqueness: true
end
