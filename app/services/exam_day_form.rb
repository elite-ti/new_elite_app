class ExamDayForm
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

	attr_accessor :super_klazz_ids, :exam_cycle_id, :super_exam_id, :datetime, :unknown_error
	validates :super_klazz_ids, :exam_cycle_id, :super_exam_id, :datetime, presence: true

	def initialize(params = {})
		@super_klazz_ids = (params[:super_klazz_ids] || []).select do |id| id.present? end
		@exam_cycle_id = params[:exam_cycle_id]
		@super_exam_id = params[:super_exam_id]
		@datetime = Time.zone.parse(params[:datetime])
	end

	def save
		return false unless valid?

		exam_days = []

		super_klazz_ids.each do |super_klazz_id|
			exam_days << ExamDay.new(
				super_klazz_id: super_klazz_id,
				exam_cycle_id: exam_cycle_id,
				super_exam_id: super_exam_id,
				datetime: datetime)
		end

		begin
			ActiveRecord::Base.transaction do 
				exam_days.each(&:save!)
			end
			return true
		rescue => e
			@unknown_error = 'Something went wrong'
			return false
		end
	end

	def persisted?
		false
	end
end