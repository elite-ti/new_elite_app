# encoding: UTF-8

class CardProcessingUploadStatusesController < ApplicationController
  # load_and_authorize_resource

  # def index
  #   @possible_dates = ExamExecution.all.map(&:datetime).map(&:to_date).uniq.sort!

  # end
  
  def index
    campus_ids = Campus.accessible_by(current_ability).map(&:id)
    @possible_dates = ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: campus_ids).map(&:id)).map(&:datetime).map(&:to_date).uniq.sort
    @amounts = {}
    @possible_dates.each do |date|
      @amounts[date] = StudentExam.where(status: 'Valid', exam_execution_id: ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: campus_ids), datetime: date.beginning_of_day..date.end_of_day)).size
    end
  end

  def show
    campus_ids = Campus.accessible_by(current_ability).map(&:id)
    exam_date = params[:id].to_date
    base =  
      StudentExam.where("grades is not null").where(
        status: StudentExam::VALID_STATUS,
        exam_execution_id:
          ExamExecution.where(
            datetime: (exam_date.beginning_of_day)..(exam_date.end_of_day)
          ).includes(:exam_cycle).select{|ee| !ee.is_bolsao}.map(&:id)
      ).includes(
        student: {enrollments: :super_klazz}, 
        exam_execution: [:exam, { super_klazz: [:campus, product_year: :product]}]
      )
    @results =
      base.select{|student_exam| student_exam.student.ra < 900000}.map do |student_exam|
        next unless student_exam.student.enrollments.select{|e| e.super_klazz_id == student_exam.exam_execution.super_klazz_id}.first.try(:erp_code).present?
        student_exam.grades.split(',').each_slice(2).map do |array|
          (["1", student_exam.exam_execution.try(:exam).try(:erp_code) || '', "N", "%06d" % (student_exam.student.try(:ra) || 0)] + array.reverse + [student_exam.student.enrollments.select{|e| e.super_klazz_id == student_exam.exam_execution.super_klazz_id}.first.try(:erp_code), student_exam.exam_execution.super_klazz.name]).join(';')
        end
      end.flatten.compact.join("\r\n")

    respond_to do |format|
      format.html
      format.csv { render text: @results }
    end
  end

end
