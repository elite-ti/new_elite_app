class Period < ActiveRecord::Base

  TIME_ARRAY = [
    '07:00', '07:50', '08:40', '10:00', '10:50', '11:40' ,
    '13:30', '14:20', '15:10', '16:30', '17:20', '18:10',
    '19:00', '19:50', '21:00', '21:50']
  
  attr_accessible :date, :position, :klazz_id, :teacher_id, 
    :subject_id, :absence_reason_id, :klazz_type_id

  belongs_to :teacher
  belongs_to :subject
  belongs_to :klazz
  belongs_to :klazz_type
  belongs_to :absence_reason

  validates :date, :position, :klazz_id, :subject_id, presence: true

  def self.time_array
    TIME_ARRAY
  end

  def future?
    return nil if date.nil? or time.nil?
    Time.zone.parse(date.to_s + ' ' + time) > Time.zone.now
  end

  def past?
    return nil if date.nil? or time.nil?
    Time.zone.parse(date.to_s + ' ' + time) < Time.zone.now
  end

  def absent?
    absence_reason.present?
  end

  # TODO: refine this constraints
  def available_subjects
    Subject.all
  end

  def available_teachers
    Teacher.all
  end

private

  def time
    TIME_ARRAY[position]
  end
end 