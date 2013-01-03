class TimeTable < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :date, :position, :replicate,
    :klazz_type_id, :teaching_assignment_id, 
    :subject_id, :teacher_id, :klazz_id,
    :teacher_absence_attributes, :linked_time_table
  attr_writer :subject_id, :teacher_id, :klazz_id
  attr_reader :replicate

  belongs_to :teaching_assignment
  belongs_to :klazz_type
  has_one :teacher_absence, dependent: :destroy
  accepts_nested_attributes_for :teacher_absence, allow_destroy: true, reject_if: :all_blank

  validates :date, :position, :teaching_assignment_id, :klazz_type_id, presence: true

  after_initialize :default_values
  before_validation :set_teaching_assignment
  after_create :create_replicas, if: 'replicate && date + 1.week <= date.end_of_year'
  after_update :update_replicas, if: 'replicate'
  after_destroy :destroy_replicas, if: 'replicate'

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

  def subject_id
    @subject_id || teaching_assignment.try(:subject).try(:id)
  end

  def teacher_id
    @teacher_id || teaching_assignment.try(:teacher).try(:id)
  end

  def klazz_id
    @klazz_id || teaching_assignment.try(:klazz).try(:id)
  end

  def replicate=(value)
    @replicate = {
      true => true, '1' => true,
      false => false, '0' => false, nil => false
    }[value]
  end

  def time
    TimeTable.time_array[position]
  end

  def datetime
    DateTime.parse(date.to_s + 'T' + TimeTable.time_array[position] + ':00-03:00')
  end

  def past?
    (not new_record?) && datetime <= Time.now
  end

  def future?
    not past?
  end

  def find_or_build_teacher_absence
    teacher_absence || build_teacher_absence
  end

private

  def default_values
    self.linked_time_table ||= (TimeTable.maximum(:linked_time_table) || 0) + 1
  end

  def set_teaching_assignment
    self.teaching_assignment_id = TeachingAssignment.find_or_create_by_klazz_id_and_subject_id_and_teacher_id(
      klazz_id: Klazz.find(klazz_id).id,
      teacher_id: Teacher.find(teacher_id).id,
      subject_id: Subject.find(subject_id).id
    ).id
  end

  def create_replicas
    TimeTable.create!(
      date: date + 1.week, 
      teaching_assignment_id: teaching_assignment_id,
      klazz_type_id: klazz_type_id,
      position: position,
      linked_time_table: linked_time_table,
      replicate: true
    )
  end

  def update_replicas
    TimeTable.update_all(
      {teaching_assignment_id: teaching_assignment_id, klazz_type_id: klazz_type_id},
      {linked_time_table: linked_time_table, date: (date..date.end_of_year)}
    )
  end

  def destroy_replicas
    TimeTable.destroy_all(linked_time_table: linked_time_table, date: (date..date.end_of_year))
  end
end 