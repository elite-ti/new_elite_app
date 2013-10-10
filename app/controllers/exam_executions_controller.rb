#encoding: utf-8

class ExamExecutionsController < ApplicationController
  # load_and_authorize_resource

  def index
    if params[:filter_by].nil?
      @exam_executions = SuperKlazz.where(campus_id: Campus.accessible_by(current_ability).map(&:id)).map(&:exam_executions).flatten.uniq
      @filter_by = ''
    elsif params[:filter_by] == 'is_bolsao'
      @exam_executions = ExamExecution.all.select{|ee| ee.is_bolsao && Campus.accessible_by(current_ability).include?(ee.super_klazz.campus)}
      @filter_by = ' - Bolsão'
    elsif params[:filter_by] == 'free_course'
      @exam_executions = SuperKlazz.where(product_year_id: ProductYear.free_course_products.map(&:id), campus_id: Campus.accessible_by(current_ability).map(&:id)).map(&:exam_executions).flatten.uniq.select{|exam_execution| !exam_execution.is_bolsao}
      @filter_by = ' - Curso'
    elsif params[:filter_by] == 'school'
      @exam_executions = SuperKlazz.where(product_year_id: ProductYear.school_products.map(&:id), campus_id: Campus.accessible_by(current_ability).map(&:id)).map(&:exam_executions).flatten.uniq.select{|exam_execution| !exam_execution.is_bolsao}
      @filter_by = ' - Colégio'
    else
      render :file => 'public/404.html', :status => :not_found, :layout => false      
    end
  end

  def attendance
    respond_to do |format|
      format.pdf do
        pdf = AttendanceListPrawn.new(params[:exam_execution_id])
        if !params[:exam_execution_id].nil?
          filename = 'ListaPresença - ' + ExamExecution.find(params[:exam_execution_id]).super_klazz.name + '.pdf'
        else
          filename = 'ListaPresença_Branco.pdf'
        end
        send_data pdf.render, filename: filename, type: "application/pdf", disposition: "inline"
      end
    end    
  end

  def cards
    @exam_execution = ExamExecution.find(params[:exam_execution_id])
    @student_exams = (@exam_execution.card_processings.map(&:student_exams).flatten + @exam_execution.student_exams).uniq
  end

  def result
    @exam_execution = ExamExecution.find(params[:exam_execution_id])
    @subjects = @exam_execution.exam.exam_subjects
    @student_exams = @exam_execution.student_exams.where(status: StudentExam::VALID_STATUS)
  end

  def consolidated_by_cicle
    if(params[:exam_cycle_id].nil?)
      render :file => 'public/404.html', :status => :not_found, :layout => false
    else
      params[:exam_cycle_id]
    end
  end
end