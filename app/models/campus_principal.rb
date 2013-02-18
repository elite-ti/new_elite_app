class CampusPrincipal < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :campus_id, :employee_id

  belongs_to :employee
  belongs_to :campus

  validates :campus, presence: true
  validates :employee_id, presence: true, uniqueness: true, on: :update

  def accessible_klazz_ids
    campus.klazzes.map(&:id)
  end
end
