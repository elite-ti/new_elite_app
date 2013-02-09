class Period < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :date, :position, :klazz_id, :teacher_id, :subject_thread_id, 
    :absence_reason_id, :klazz_type_id

  belongs_to :teacher
  belongs_to :subject_thread
  belongs_to :klazz
  belongs_to :klazz_type
  belongs_to :absence_reason

  validates :date, :position, :klazz_id, :subject_thread_id, presence: true

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

  # TODO: refine this constraints
  
  def available_subject_threads
    klazz.year.subject_threads
  end

  def available_teachers
    Teacher.all
  end
end 