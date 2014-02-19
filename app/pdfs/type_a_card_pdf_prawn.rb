#encoding: UTF-8

class TypeACardPdfPrawn < Prawn::Document
  def initialize(exam_execution_id, student_id)
    @exam_execution = ExamExecution.find(exam_execution_id) if !exam_execution_id.nil?
    @student = Student.find(student_id) if !student_id.nil?
    super(page_size: "A4", page_layout: :portrait, top_margin: 20)
    set_default_parameters
    if !@exam_execution.nil? && !@student.nil?
      page(@student)
    elsif !@exam_execution.nil?
      ExamExecution.find(@exam_execution).super_klazz.enrolled_students.sort_by{|std| std.name}.each do |student|
        page(student)
      end
    else
      page(nil)
    end
  end

private
  def page(student)
    if @first_page
      @first_page = false
    else
      start_new_page
    end
    header
    content
    paint_options(student) if(!student.nil?)
    markers
    bottom    
  end
  def set_default_parameters
    font "Helvetica"
    self.line_width = 0.1
    @option_width = 14
    @option_height = 7
    @horizontal_space_between_options = 5
    @vertical_space_between_options = 3
    @horizontal_space_between_groups = 40
    @first_page = true
  end

  def header
    move_down 20
    text "Cartão-Resposta", size: 20, style: :bold, :align => :center
    move_down 10
    text "Aluno: ", size: 12
    draw_blank_line
    move_down 10
    text "Prova: ", size: 12
    draw_blank_line
    move_down 10
    text "Data: ", size: 12
    draw_blank_line 40, 100
    move_up 5
    text 'Preencha o seu RA', size: 12, :align => :center
  end

  def bottom
    rectangle [100, 30], 310, 30
    stroke
    draw_text 'Assinatura', at: [225, 40], size: 12
  end

  def draw_blank_line start_x = 40, length = 460
    stroke_line [start_x, cursor + 4], [start_x + length, cursor + 4]
  end

  def content
    draw_block 0..9, 6, 1, 170, 650, false
    draw_block 'A'..'E', 50, 2, 150, 560, true
  end

  def draw_block options, repetitions, groups, start_x, start_y, print_number
    (0..groups-1).each do |group|
      (0..repetitions-1).each do |repetition|
        if print_number
          draw_text (repetition + group * repetitions + 1).to_s, at: [start_x - 15 + group * (options.to_a.size * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), start_y - 6.5 - repetition * (@option_height + @vertical_space_between_options)], size: 8
        else
          rectangle [start_x - 15 + group * (options.to_a.size * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), start_y + @vertical_space_between_options/2 + 0.5 - repetition * (@option_height + @vertical_space_between_options)], @option_height + @vertical_space_between_options, 10
        end
        options.each_with_index do |option, index|
          rectangle [start_x + (@option_width + @horizontal_space_between_options)*index + group * (options.to_a.size * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), start_y - repetition * (@option_height + @vertical_space_between_options)], @option_width, @option_height
          stroke
          draw_text (option).to_s, at: [start_x + 5.5 + (@option_width + @horizontal_space_between_options)*index + group * (options.to_a.size * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), start_y - 5.5 - repetition * (@option_height + @vertical_space_between_options)], size: 6
        end
      end
    end
  end

  def markers
    rectangle [-20, 0], 20, 20
    fill
    rectangle [-20, 790], 20, 20
    fill
    rectangle [525, 0], 20, 20
    fill
  end

  def paint_options student
    ra = "%06d" % student.ra
    group = 0
    ra.split('').each_with_index do |char, index|
      rectangle [170 + (@option_width + @horizontal_space_between_options)*char.to_i + group * (10 * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), 650 - index * (@option_height + @vertical_space_between_options)], @option_width, @option_height
      fill
      draw_text char, at: [170 - 12 + group * (10 * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), 650 - 6 - index * (@option_height + @vertical_space_between_options)], size: 8
    end
    draw_text student.name, at: [45, 725], size: 12
    draw_text @exam_execution.full_name, at: [45, 701], size: 12
    draw_text @exam_execution.datetime.strftime('%d/%m/%Y'), at: [45, 677], size: 12
  end
end
