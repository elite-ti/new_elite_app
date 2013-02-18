class Admin < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :employee_id

  belongs_to :employee
  
  validates :employee_id, presence: true, uniqueness: true

  def accessible_campus_ids
    Campus.all.map(&:id)
  end
end