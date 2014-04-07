#encoding: utf-8

class ProductYear < ActiveRecord::Base
  
  attr_accessible :name, :product_id, :year_id
  SCHOOL_PRODUCT_NAMES = ['6º Ano', '7º Ano', '8º Ano', '1ª Série ENEM', '2ª Série ENEM']

  belongs_to :product
  belongs_to :year

  has_many :exam_cycles, dependent: :destroy
  has_many :subject_threads, dependent: :destroy
  has_many :super_klazzes, dependent: :destroy

  validates :product_id, :name, :year_id, presence: true
  validates :name, uniqueness: true 

  def is_school_product?
    SCHOOL_PRODUCT_NAMES.include?(name)
  end

  def is_free_course_product?
    !SCHOOL_PRODUCT_NAMES.include?(name)
  end

  def self.school_products
    ProductYear.where(product_id: Product.where(name: SCHOOL_PRODUCT_NAMES), year_id: Year.last.id)
  end

  def self.free_course_products
    # ProductYear.where("name not in (?)", SCHOOL_PRODUCT_NAMES).where(year_id: Year.last.id)
    ProductYear.where("product_id not in (?)", Product.where(name: SCHOOL_PRODUCT_NAMES)).where(year_id: Year.last.id)
  end
end
