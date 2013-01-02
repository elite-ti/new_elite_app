class CampusPreference < ActiveRecord::Base
  attr_accessible :campus_id, :teacher_id

  belongs_to :campus
  belongs_to :teacher

  validates :campus_id, :teacher_id, presence: true
  validates :campus_id, uniqueness: { scope: :teacher_id }
end
