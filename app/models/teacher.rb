class Teacher < ActiveRecord::Base
  has_paper_trail
  
  attr_accessible :employee_id, :nickname, :subject_ids,
    :product_group_preferences_attributes, :campus_ids, :morning, :afternoon, :evening, 
    :saturday_moning, :saturday_afternoon, :sunday_morning, :sunday_afternoon, 
    :agree_with_terms, :administrative_job,
    :graduated, :major_id, :institute, :bachelor, :cref, :time_teaching, 
    :post_graduated, :post_graduated_comment, :professional_experiences, 
    :professional_experiences_attributes, :campus_preference_ids

  belongs_to :employee
  belongs_to :major

  has_many :teached_subjects, dependent: :destroy
  has_many :subjects, through: :teached_subjects

  has_many :campus_preferences, dependent: :destroy
  has_many :campuses, through: :campus_preferences

  has_many :product_group_preferences, dependent: :destroy
  accepts_nested_attributes_for :product_group_preferences, 
    reject_if: proc { |attributes| attributes['preference'].blank? }
  has_many :products, through: :product_group_preferences

  has_many :teaching_assignments, dependent: :destroy
  has_many :klazzes, through: :teaching_assignments
  has_many :schedules, through: :teaching_assignments
  has_many :time_tables, through: :teaching_assignments

  has_many :teacher_absences, dependent: :destroy

  has_many :professional_experiences, dependent: :destroy
  accepts_nested_attributes_for :professional_experiences, allow_destroy: true, reject_if: :all_blank

  validates :employee_id, :nickname, presence: true, on: :update

  def find_time_tables_by_date_and_position(date, position)
    time_tables_by_date(date).select { |time_table| time_table.position == position }
  end

  def time_tables_by_date(date)
    @time_tables_by_date ||= Hash.new do |hash, key|
      hash[key] = get_time_tables_by_date(*key)
    end
    @time_tables_by_date[date]
  end

  def build_product_group_preferences
    ProductGroup.all.each do |product_group|
      next if product_group_preferences.map(&:product_group).include?(product_group)
      product_group_preferences.build(product_group_id: product_group.id)
    end
  end

  def find_absent_time_tables_by_date(date)
    time_tables.order(:date).
      joins(:teacher_absence).
      includes(teaching_assignment: [:teacher, :subject, :klazz]).
      where(date: date.beginning_of_month..date.end_of_month)
  end

  def find_monthly_time_tables(date)
    start_date, end_date = set_active_month_interval(date)
    return [] if start_date.nil? or end_date.nil?
    time_tables.order(:date).
      includes(:teacher_absence, teaching_assignment: [:teacher, :subject, :klazz]).
      where(date: start_date..end_date)
  end

  def find_monthly_time_tables_as_substitute(date)
    start_date, end_date = set_active_month_interval(date)
    return [] if start_date.nil? or end_date.nil?
    # teacher_absences.includes(:time_table).where(time_tables: {date: start_date..end_date})
    TimeTable.joins(:teacher_absence).where(date: start_date..end_date, teacher_absences: {teacher_id: id})
  end

private

  def get_time_tables_by_date(date)
    time_tables.includes({teaching_assignment: [:subject, :klazz]}).order('date asc').where(date: date)
  end

  def set_active_month_interval(date)
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    today = Date.today

    return [] if today < start_date
    end_date = today if today < end_date

    return [start_date, end_date]
  end
end
