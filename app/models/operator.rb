class Operator < ActiveRecord::Base
  
  attr_accessible :employee_id

  belongs_to :employee
  
  validates :employee_id, presence: true, uniqueness: true
end