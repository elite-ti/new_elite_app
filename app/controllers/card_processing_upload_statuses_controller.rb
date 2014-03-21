# encoding: UTF-8

class CardProcessingUploadStatusesController < ApplicationController
  # load_and_authorize_resource

  # def index
  #   @possible_dates = ExamExecution.all.map(&:datetime).map(&:to_date).uniq.sort!

  # end
  
  def index
    exam_executions = ExamExecution.where(exam_cycle_id: ExamCycle.where(is_bolsao: false))
    @possible_dates = exam_executions.map(&:datetime).map(&:to_date).uniq.sort
    @amounts = Hash[* @possible_dates.map{|date| [date,0]}.flatten + [Date.new(1900, 1, 1), 0]]
    
    translations = Hash[* exam_executions.map{|exam_execution| [exam_execution.id, exam_execution.datetime.to_date]}.flatten]
    translations[nil] = Date.new(1900, 1, 1)
    StudentExam.where(status: 'Valid').count(group: "exam_execution_id").each do |exam_execution_id, count|
      date = translations[exam_execution_id] || Date.new(1900, 1, 1)
      @amounts[date] = @amounts[date] + count
    end
  end

  def results
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
      base.select{|student_exam| (student_exam.student.try(:ra) || 900001) < 900000}.map do |student_exam|
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

  def markings
    exam_date = params[:id].to_date
    @results =  
      StudentExam.where("exam_answer_as_string is not null").where(
        status: StudentExam::VALID_STATUS,
        exam_execution_id:
          ExamExecution.where(
            datetime: (exam_date.beginning_of_day)..(exam_date.end_of_day),
            exam_cycle_id: ExamCycle.where(is_bolsao: false)
          )
      ).includes(
        :student
      ).map{|student_exam| ("%06d" % (student_exam.student.try(:ra) || 0)) + student_exam.exam_answer_as_string}.compact.join("\r\n")

    respond_to do |format|
      format.html
      format.csv { render text: @results }
    end
  end

  def scanned
    exam_date = params[:id].to_date
    @results = 
      StudentExam.where(
        card_processing_id: CardProcessing.where(is_bolsao: false, exam_date: exam_date).map(&:id)
      ).map do |student_exam| 
        student_exam.student_number = (student_exam.student_number.to_i / 10).to_s if student_exam.student_number.size > 6
        [
          student_exam.id, 
          'Z' * (6 - student_exam.student_number.size) + student_exam.student_number + student_exam.string_of_answers + 'Z' * (100 - student_exam.string_of_answers.size)
        ].join(';')
      end.compact.join("\r\n")

    respond_to do |format|
      format.html
      format.csv { render text: @results }
    end
  end

end
