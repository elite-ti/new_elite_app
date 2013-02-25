class CampusPrincipal < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :employee_id, :campus_ids

  belongs_to :employee
  has_many :campus_principal_campuses, dependent: :destroy, inverse_of: :campus_principal
  has_many :campuses, through: :campus_principal_campuses

  validates :employee_id, presence: true, uniqueness: true
end
