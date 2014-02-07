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
    @results = 
      StudentExam.where(
        exam_execution_id:
          ExamExecution.where(
            datetime: (exam_date.beginning_of_day)..(exam_date.end_of_day), 
            super_klazz_id: SuperKlazz.where(campus_id: campus_ids).map(&:id)
          ).map(&:id)
      ).map{|student_exam| [student_exam.student.ra, student_exam.exam_execution.exam.code, student_exam.string_of_answers].join(';')}
    respond_to do |format|
      format.html
      format.csv { render text: @results.to_csv }
    end
  end
end
