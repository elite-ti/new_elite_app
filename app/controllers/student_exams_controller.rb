#encoding: UTF-8

class StudentExamsController < ApplicationController
  load_and_authorize_resource

  def show
    @translations = {'Being processed' => 'Em processamento', 'Error' => 'Erro', 'Student not found' => 'Aluno não encontrado', 'Exam not found' => 'Prova não encontrada', 'Invalid answers' => 'Respostas inválidas', 'Valid' => 'Válido', 'Repeated student' => 'Aluno Repetido'}
  end

  def edit
    set_form_objects
  end

  def update
    update_student_exam = UpdateStudentExam.new(params[:student_exam], @student_exam)
    if update_student_exam.update
      if params[:commit] == 'Finalizar'
        redirect_to @student_exam.card_processing, notice: 'Changes applied!'
      else
        check_student_exams
      end
    else
      if params[:commit] == 'Finalizar'
        redirect_to @student_exam.card_processing, notice: 'Changes not applied.'
      else
        set_form_objects
        render :edit
      end
    end
  end

  def error
    @student_exam = StudentExam.find(params[:id])
    @student_exam.error!
    redirect_to @student_exam.card_processing, notice: 'Student exam was marked as error.'
  end

  def new
    respond_to do |format|
      format.pdf do
        pdf = TypeCCardPdfPrawn.new(params[:exam_execution_id], params[:student_id], params[:paint])
        if !params[:exam_execution_id].nil? && !params[:student_id].nil?
          filename = 'CartaoResposta - ' + Student.find(params[:student_id]).name + ' - ' + ExamExecution.find(params[:exam_execution_id]).name + '.pdf'
        elsif !params[:exam_execution_id].nil?
          filename = 'CartoesResposta - ' + ExamExecution.find(params[:exam_execution_id]).name + '.pdf'
        else
          filename = 'CartaoResposta_Branco.pdf'
        end
        send_data pdf.render, filename: filename, type: "application/pdf", disposition: "inline"
      end
    end
  end

private

  def check_student_exams
    needing_check =  @student_exam.card_processing.student_exams.needing_check
    if needing_check.any?
      redirect_to edit_student_exam_path(needing_check.first!), 
        notice: 'Some fields need to be checked.'
    else
      redirect_to @student_exam.card_processing, 
        notice: 'All cards were checked!'
    end
  end

  def set_form_objects
    if @student_exam.student_not_found? || @student_exam.error? || @student_exam.repeated_student?
      @possible_students = @student_exam.possible_students
      @new_student = @student_exam.student || @student_exam.build_student
    end
  end
end
