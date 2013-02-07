class KlazzPeriod < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :date, :position, :klazz_id 
  attr_writer :klazz_id, :teacher_id, :subject_id

  belongs_to :teaching_assignment
  belongs_to :klazz_type
  has_one :teacher_absence, dependent: :destroy

  validates :date, :position, :teaching_assignment_id, :klazz_type_id, presence: true

  def self.time_hash
    {
      morning: [ '07:00', '07:50', '08:40', '10:00', '10:50', '11:40' ], 
      afternoon: ['13:30', '14:20', '15:10', '16:30', '17:20', '18:10'], 
      evening: ['19:00', '19:50', '21:00', '21:50']
    }
  end

  def self.time_array
    time_hash.values.flatten
  end

  def self.new_from_klazz(klazz_id, date, position)
    new(klazz_id: klazz_id, date: date, position: position)
  end

  def teacher_id
    teaching_assignment.try(:teacher).try(:id)
  end

  def subject_id
    teaching_assignment.try(:teacher).try(:id)
  end
end 