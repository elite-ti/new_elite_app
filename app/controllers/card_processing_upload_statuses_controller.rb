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
      format.csv do
        response.headers['Content-Disposition'] = "attachment; filename=\"results_#{exam_date.strftime('%Y-%m-%d')}.csv\""
        render text: @results.encode("ISO-8859-1", "utf-8")
      end
    end
  end

  def scanned
    exam_date = params[:id].to_date
    @results = (['*VALORES POSSIVELMENTE ALTERADOS PELOS COORDENADORES', 'RA ALUNO;CODIGO PROVA;RESPOSTAS'] +
      StudentExam.where("exam_answer_as_string is not null").where(
        status: StudentExam::VALID_STATUS,
        exam_execution_id:
          ExamExecution.where(
            datetime: (exam_date.beginning_of_day)..(exam_date.end_of_day),
            exam_cycle_id: ExamCycle.where(is_bolsao: false)
          )
      ).includes(
        :student
      ).map do |student_exam|
        [
          `md5sum #{student_exam.card.png.path}`.split[0] || '00000000000000000000000000000000',
          ("%06d" % (student_exam.student.try(:ra) || 0)),
          ("%05d" % (student_exam.exam_execution.try(:exam).try(:code) || 0)),
          student_exam.exam_answer_as_string.gsub('Z','X').gsub('W','Z').gsub('X','W')
        ].join(';')
      end.compact).join("\r\n")

    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Disposition'] = "attachment; filename=\"cards_data_#{exam_date.strftime('%Y-%m-%d')}.csv\""
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
        student_exam.student_number = (student_exam.student_number.to_i / 10).to_s if student_exam.student_number && student_exam.student_number.size > 6
        [
          student_exam.id,
          'Z' * (6 - student_exam.student_number.size) + student_exam.student_number,
          'Z' * (5 - (student_exam.exam_code.try(:size) || 0)) + (student_exam.exam_code || ''),
          student_exam.string_of_answers + 'Z' * (100 - student_exam.string_of_answers.size)
        ].join(';')
      end.compact).join("\r\n")

    respond_to do |format|
      format.html
      format.csv do
        response.headers['Content-Disposition'] = "attachment; filename=\"markings_#{exam_date.strftime('%Y-%m-%d')}.csv\""
        render text: @results.encode("ISO-8859-1", "utf-8")
      end
    end
  end

  def recalculate
    exam_date = params[:id].to_date
    CardProcessing.where(is_bolsao: false, exam_date: exam_date).map(&:exam_execution).uniq.map(&:exam).uniq.each do |exam|
      correct_answers = exam.correct_answers
      next if !correct_answers.present?
      number_of_questions = Hash[*exam.exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).map(&:code).group_by{|a| a}.map{|a,b| [a, b.size]}.flatten]
      subjects = exam.exam_questions.map(&:question).map(&:topics).map(&:first).map(&:subject).map(&:code)
      # StudentExam.where(exam_execution_id: exam.exam_executions.map(&:id), status: 'Valid').where("grades is null or grades like '%,0%'").each do |se|
      StudentExam.where(exam_execution_id: exam.exam_executions.map(&:id), status: 'Valid').each do |se|
        grades = Hash[*subjects.uniq.map{|a| [a,0]}.flatten]
        se.exam_answer_as_string.split('').each_with_index do |answer, index|
          if correct_answers[index] == 'X' || answer == correct_answers[index]
          grades[subjects[index]] = grades[subjects[index]] + 1
          end
        end
        grades.each{ |key,value| grades[key] = (10*value.to_f / number_of_questions[key].to_f).round(2) }
        se.update_column(:grades, grades.to_a.flatten.join(','))
      end
      break
    end
    redirect_to card_processing_upload_statuses_url, notice: "Notas recalculadas com sucesso."
  end

end
