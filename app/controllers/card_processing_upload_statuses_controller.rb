# encoding: UTF-8

class CardProcessingUploadStatusesController < ApplicationController
  # load_and_authorize_resource

  # def index
  #   @possible_dates = ExamExecution.all.map(&:datetime).map(&:to_date).uniq.sort!

  # end
  
  def index
    exam_executions = ExamExecution.where(exam_cycle_id: ExamCycle.where(is_bolsao: false))
    campus_ids = Campus.accessible_by(current_ability).map(&:id)
    @possible_dates = ExamExecution.where(super_klazz_id: SuperKlazz.where(campus_id: campus_ids).map(&:id)).map(&:datetime).map(&:to_date).uniq.sort
    @amounts = Hash[* @possible_dates.map{|date| [date,0]}.flatten + [Date.new(1900, 1, 1), 0]]

    translations = Hash[* exam_executions.map{|exam_execution| [exam_execution.id, exam_execution.datetime.to_date]}.flatten]
    translations[nil] = Date.new(1900, 1, 1)
    StudentExam.where(status: 'Valid').count(group: "exam_execution_id").each do |exam_execution_id, count|
      date = translations[exam_execution_id] || Date.new(1900, 1, 1)
      @amounts[date] = @amounts[date] + count
    end
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
      # ).map{|student_exam| ["1", "301", "N", "%06d" % student_exam.student.ra,student_exam.grades].join(';')}
      
    respond_to do |format|
      format.html
      format.csv { render text: @results.to_csv }
    end
  end

  def scanned
    exam_date = params[:id].to_date
    @results = 
      StudentExam.where(
        card_processing_id: 
          CardProcessing.where(
            exam_execution_id:
              ExamExecution.where(
                datetime: (exam_date.beginning_of_day)..(exam_date.end_of_day),
                exam_cycle_id: ExamCycle.where(is_bolsao: false)
              )
          )
      ).includes(
        :student, exam_execution: :exam
      ).map do |student_exam|
        [
          # has student
          if student_exam.student && student_exam.student.ra
            ("%08d" % (student_exam.student.ra))
          else
            student_exam.student_number
          end,
          # has exam_code
          # if student_exam.exam_execution && student_exam.exam_execution.exam && student_exam.exam_execution.exam.code
          #   ("%05d" % (student_exam.exam_execution.exam.code.to_i))
          # else
          #   student_exam.exam_code
          # end,
          student_exam.exam_code,
          student_exam.string_of_answers.gsub('Z','X').gsub('W','Z').gsub('X','W')
        ].join()
      end.compact.join("\r\n")

    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Disposition'] = "attachment; filename=\"cards_data_#{exam_date.strftime('%Y-%m-%d')}.txt\""
        render text: @results.encode("ISO-8859-1", "utf-8")
      end
    end
  end

  def markings
    exam_date = params[:id].to_date
    @results = (['ID CARTAO;RA ALUNO;CODIGO PROVA;RESPOSTAS'] +
      StudentExam.where(
        card_processing_id: CardProcessing.where(is_bolsao: false, exam_date: exam_date).map(&:id)
      ).map do |student_exam|
        student_exam.student_number = (student_exam.student_number.to_i / 10).to_s if student_exam.student_number.size > 6
        [
          student_exam.id,
          'Z' * (8 - student_exam.student_number.size) + student_exam.student_number,
          'Z' * (5 - (student_exam.exam_code.try(:size) || 0)) + (student_exam.exam_code || ''),
          student_exam.string_of_answers + 'Z' * (100 - student_exam.string_of_answers.size)
        ].join(';')
      end.compact).join("\r\n")

    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Disposition'] = "attachment; filename=\"markings_#{exam_date.strftime('%Y-%m-%d')}.txt\""
        render text: @results.encode("ISO-8859-1", "utf-8")
      end
    end
  end

end
