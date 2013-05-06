class CampusPrincipalCampus < ActiveRecord::Base
  
  attr_accessible :campus_principal_id, :campus_id

  belongs_to :campus_principal, inverse_of: :campus_principal_campuses
  belongs_to :campus

  validates :campus_principal, :campus, presence: true
  validates :campus_principal_id, uniqueness: { scope: :campus_id }
end
