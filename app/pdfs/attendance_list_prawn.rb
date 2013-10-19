#encoding: UTF-8

class AttendanceListPrawn < Prawn::Document
  def initialize(exam_execution_id)
    super(page_size: "A4", page_layout: :portrait, top_margin: 40)
    # set_default_parameters
    @exam_execution = ExamExecution.find(exam_execution_id)
    
    @students = [['Código', 'Aluno', 'Assinatura']]
    if @exam_execution.is_bolsao
      @students += @exam_execution.super_klazz.applicant_students.map do |student| 
          ["%06d" % student.number, 
            student.name.split.map(&:mb_chars).map(&:capitalize).join(' '), 
            ''
          ]
        end.sort_by{|row| row[1]} + [['', '', '']]*65
    else
      @students += @exam_execution.super_klazz.enrolled_students.map do |student| 
          ["%06d" % student.ra, 
            student.name.split.map(&:mb_chars).map(&:capitalize).join(' '), 
            ''
          ]
        end.sort_by{|row| row[1]} + [['', '', '']]*65
    end
    @product_name = ExamExecution.find(exam_execution_id).super_klazz.product_year.product.name
    @campus_name = ExamExecution.find(exam_execution_id).super_klazz.campus.name
    @date = ExamExecution.find(exam_execution_id).datetime.strftime('%d/%m/%Y')
    header
    content
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
    text_box @date, at: [440, 750], size: 12, width: 80, align: :center
    text_box @campus_name, at: [440, 730], size: 12, width: 80, align: :center
    image "#{Rails.root}/app/assets/images/elite-logo.png", at:[10, 770], fit: [70, 70]
  end
  def content
    move_down 20
    # table(@students, 
    #   :headers => [
    #     {text: , font_style: :bold, align: :center},
    #     {text: '', font_style: :bold, align: :center},
    #     {text: '', font_style: :bold, align: :center}],
    #   row_colors: ["FFFFFF", "F0F0F0"], 
    #   column_widths: [50, 300, 173], 
    #   cell_style: {:height => 24}
    # )

    table(@students, :header => true, row_colors: ["FFFFFF", "F0F0F0"], column_widths: [53, 300, 170], cell_style: {:height => 18, :size => 9.5}) do |tbl|
      tbl.row(0).font_style = :bold
      tbl.row(0).align = :center
      tbl.row(0).background_color = 'D0D0D0'
    end
  end
end