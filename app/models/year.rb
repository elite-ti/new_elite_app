class Year < ActiveRecord::Base
  has_paper_trail

  attr_accessible :end_date, :number, :start_date

  has_many :product_years

  validates :start_date, :end_date, :number, presence: true
  validates :number, uniqueness: true
end
