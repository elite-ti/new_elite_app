class ProfessionalExperience < ActiveRecord::Base
  has_paper_trail

  belongs_to :school_role
  belongs_to :teacher

  attr_accessible :school_name, :school_role_id, :teacher_id

  validates :teacher_id, presence: true
end
