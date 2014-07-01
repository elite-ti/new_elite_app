#encoding: UTF-8

class AttendanceListPrawn < Prawn::Document
  def initialize(exam_execution_id, bolsao_id=nil, group_name=nil, campus_id=nil)
    super(page_size: "A4", page_layout: :portrait, top_margin: 40)
    # set_default_parameters
    if exam_execution_id.nil?
      @product_name = group_name
      @campus_name = Campus.find(campus_id).name
      @date = Applicant.where(bolsao_id: bolsao_id, group_name: group_name, exam_campus_id: campus_id).first.exam_datetime.strftime('%d/%m/%Y')
      @students = [['Código', 'Aluno', 'Assinatura']]
      Applicant.where(bolsao_id: bolsao_id, group_name: group_name, exam_campus_id: campus_id).each do |applicant|
        @students << [applicant.number, applicant.student.name, '']
      end
      30.times do
        @students << ['', '', '']
      end
      @is_bolsao = false

    else
      @exam_execution = ExamExecution.find(exam_execution_id)
      @product_name = ExamExecution.find(exam_execution_id).super_klazz.product_year.product.name
      @campus_name = ExamExecution.find(exam_execution_id).super_klazz.campus.name
      @date = ExamExecution.find(exam_execution_id).datetime.strftime('%d/%m/%Y')
      @is_bolsao = @exam_execution.is_bolsao

      @students = [['Código', 'Aluno', 'Assinatura']]
      if @exam_execution.is_bolsao
        exam_date = @exam_execution.datetime.to_date
        p "#{@exam_execution.id}: #{exam_date}"
        pre_students = @exam_execution.super_klazz.applicant_students.select{|s| !s.applicants.first.exam_datetime.nil? && s.applicants.first.exam_datetime > exam_date.beginning_of_day && s.applicants.first.exam_datetime < exam_date.end_of_day}
        if @exam_execution.full_name =~ /.*Bolsão 2014 - Tarde.*/
          pre_students = pre_students.select{|student| student.applicants.first.exam_datetime.nil? || student.applicants.first.exam_datetime > (@date + ' 12:00').to_datetime}
          @shift = 'Tarde'
        else
          pre_students = pre_students.select{|student| student.applicants.first.exam_datetime.nil? || student.applicants.first.exam_datetime <= (@date + ' 12:00').to_datetime}
          @shift = 'Manhã'
        end
        @students += pre_students.map do |student| 
            ["%06d" % student.number, 
              student.name.split.map(&:mb_chars).map(&:capitalize).join(' '), 
              ''
            ]
          end.sort_by{|row| ActiveSupport::Inflector.transliterate(row[1]).upcase} + [['', '', '']]*65
      else
        @sorted_by_klazz = true
        @student_header = @students
        @students_grouped = @exam_execution.super_klazz.enrollments.map do |enrollment| 
          ["%06d" % (enrollment.student.ra || 0), 
            enrollment.student.name.split.map(&:mb_chars).map(&:capitalize).join(' '), 
            enrollment.erp_code || ''
          ]
        # end.sort_by{|row| [row[2], ActiveSupport::Inflector.transliterate(row[1]).upcase]} + [['', '', '']]*65
        end.group_by{|row| row[2]}
      end      
    end

    if @sorted_by_klazz
      first_page = true
      @students_grouped.each do |klazz, students|
        if first_page
          first_page = false
        else
          start_new_page
        end
        @klazz = klazz
        @students = @student_header + students.map{|row| [row[0], row[1], '']}.sort_by{|row| ActiveSupport::Inflector.transliterate(row[1]).upcase} + [['', '', '']]*20
        header
        content
      end
    else
      header
      content
    end
  end

private
  def set_default_parameters
    font "Helvetica"
    self.line_width = 0.1
  end

  def header
    text "Lista de Presença", size: 24, style: :bold, :align => :center
    move_down 10
    text @product_name, size: 20, style: :bold, :align => :center
    text_box @date, at: [440, 755], size: 12, width: 80, align: :right
    text_box @shift, at: [440, 735], size: 12, width: 80, align: :center if @is_bolsao
    text_box @klazz, at: [360, 735], size: 12, width: 160, align: :right if @sorted_by_klazz
    text_box @campus_name, at: [400, 715], size: 12, width: 120, align: :right
    image "#{Rails.root}/app/assets/images/elite-logo.png", at:[10, 770], fit: [70, 70]
  end
  def content
    move_down 20
    table(@students, :header => true, row_colors: ["FFFFFF", "F0F0F0"], column_widths: [53, 300, 170], cell_style: {:height => 18, :size => 9.5}) do |tbl|
      tbl.row(0).font_style = :bold
      tbl.row(0).align = :center
      tbl.row(0).background_color = 'D0D0D0'
    end
  end
end