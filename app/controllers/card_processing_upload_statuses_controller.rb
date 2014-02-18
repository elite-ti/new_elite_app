# encoding: UTF-8

class CardProcessingUploadStatusesController < ApplicationController
  # load_and_authorize_resource

  # def index
  #   @possible_dates = ExamExecution.all.map(&:datetime).map(&:to_date).uniq.sort!

  # end
  
  def index
    campus_ids = Campus.accessible_by(current_ability).map(&:id)
    @possible_dates = ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: campus_ids).map(&:id)).map(&:datetime).map(&:to_date).uniq.sort
  end

  def show
    campus_ids = Campus.accessible_by(current_ability).map(&:id)
    exam_date = params[:id].to_date
    base =  
      StudentExam.where(
        status: StudentExam::VALID_STATUS,
        exam_execution_id:
          ExamExecution.where(
            datetime: (exam_date.beginning_of_day)..(exam_date.end_of_day)
          ).includes(:exam_cycle).select{|ee| !ee.is_bolsao}.map(&:id)
      )
    @results =
      base.select{|student_exam| student_exam.student.ra.to_s.size <= 6}.map do |student_exam|
        student_exam.grades.split(',').each_slice(student_exam.grades.split(',').size/2).map do |array|
          (["1", "301", "N", "%06d" % (student_exam.student.ra || 0)] + array).join(';')
        end
      end.flatten.join("\r\n")

    respond_to do |format|
      format.html
      format.csv { render text: @results }
    end
  end

end
