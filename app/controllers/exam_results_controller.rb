class ExamResultsController < ApplicationController
  authorize_resource class: false

  def index
    respond_to do |format|
      format.html { @accessible_campuses = Campus.accessible_by(current_ability) }
      format.json do 
        exam_result = params[:exam_result]
        render json: exam_results_hash(exam_result[:campus_id], exam_result[:product_year_id], exam_result[:date]).to_json 
      end
    end
    # @accessible_campuses << 'Consolidado'
  end

private

  def exam_results_hash(campus_id, product_year_id, date)
    super_klazz = SuperKlazz.where(
      product_year_id: product_year_id,
      campus_id: campus_id).first!
    date = Date.parse(date)

    date_interval = (date.beginning_of_day)..(date.end_of_day)
    exam_days = ExamDay.where(datetime: date_interval, super_klazz_id: super_klazz.id)
    student_exams = StudentExam.where(exam_day_id: exam_days.map(&:id)).includes(:student) #, :exam_answers)

    student_exams.map do |student_exam|
      student = student_exam.student
      {'ra' => student.ra, 'name' => student.name, 'grade' => student_exam.grade}
    end
  end
end
