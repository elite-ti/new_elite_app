class Product < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :product_type_id, :product_group_id, :name, :prefix, :suffix

  belongs_to :product_type
  belongs_to :product_group

  has_many :product_years, dependent: :destroy
  has_many :super_klazzes, through: :product_years
  has_many :klazzes, through: :super_klazzes
  has_many :periods, through: :klazzes

  has_many :product_head_teacher_products, dependent: :destroy
  has_many :product_head_teachers, through: :product_head_teacher_products

  has_many :campus_head_teacher_products, dependent: :destroy
  has_many :campus_head_teachers, through: :campus_head_teacher_products

  has_many :subject_head_teacher_products, dependent: :destroy
  has_many :subject_head_teachers, through: :subject_head_teacher_products

  has_many :product_preferences, dependent: :destroy
  has_many :teachers_with_preference, through: :product_preferences, source: :teachers

  has_many :campus_principal_products, dependent: :destroy
  has_many :campus_principals, through: :campus_principal_products

  validates :product_type_id, :name, presence: true
  validates :name, uniqueness: { scope: :product_type_id }
end
