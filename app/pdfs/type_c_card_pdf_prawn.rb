#encoding: UTF-8

class TypeCCardPdfPrawn < Prawn::Document
  def initialize(exam_execution_id, student_id, answers, exam_date=nil, campus_id=nil)
    @exam_execution = ExamExecution.find(exam_execution_id) if !exam_execution_id.nil?
    @full_name = @exam_execution.full_name if !exam_execution_id.nil?
    @student = Student.find(student_id) if !student_id.nil?
    @answers = answers
    @student_block_size = 6
    @exam_block_size = 5
    @exam_date = exam_date.to_date if !exam_date.nil?
    super(page_size: "A4", page_layout: :portrait, top_margin: 20)
    set_default_parameters
    if !@exam_execution.nil? && !@student.nil?
      page(@student, @exam_execution)
    elsif !@exam_execution.nil?
      ExamExecution.find(@exam_execution).super_klazz.enrollments.group_by{|enrollment| enrollment.erp_code || ''}.each do |erp_code, enrollments|
        enrollments.sort_by{|enrollment| ActiveSupport::Inflector.transliterate(enrollment.student.name).upcase}.each do |enrollment|
          page(enrollment.student, @exam_execution, erp_code)
        end
      end
    elsif !@exam_date.nil?
      ExamExecution.where(exam_cycle_id: ExamCycle.where(is_bolsao: false), datetime: (@exam_date.beginning_of_day)..(@exam_date.end_of_day), super_klazz_id: SuperKlazz.where(campus_id: campus_id)).each do |exam_execution|
        p exam_execution.full_name
        exam_execution.super_klazz.enrolled_students.sort_by{|student| student.name.split.map(&:mb_chars).map(&:capitalize).join(' ')}.each do |student|
          page(student,exam_execution)
        end
      end
    else
      page(nil)
    end
  end

private
  def page(student, exam_execution=nil, erp_code='')
    if @first_page
      @first_page = false
    else
      start_new_page
    end
    header
    content
    paint_student_options(student, erp_code) if(!student.nil?)
    paint_exam_options(exam_execution) if(!exam_execution.nil?)
    paint_answers if (!@answers.nil?)
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
    move_down 10
    text "Cartão-Resposta", size: 20, style: :bold, :align => :center
    move_down 20
    text "Aluno: ", size: 12
    draw_blank_line
    move_down 10
    text "Prova: ", size: 12
    draw_blank_line
    move_down 10
    text "Data: ", size: 12
    draw_blank_line 40, 80
    draw_text 'Turma: ', at: [300, 675]
    draw_blank_line 350, 150
    move_down 10
    text 'Preencha o seu RA e Código da Prova', size: 12, :align => :center
    image "#{Rails.root}/app/assets/images/elite-logo-bw.png", at:[130, 790], fit: [40, 40]    
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
    draw_block 0..9, @student_block_size, 1, 50, 635, false
    draw_block 0..9, @exam_block_size, 1, 280, 630, false
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

  def paint_student_options student, erp_code
    ra = "%06d" % ((student.ra || 0) % (10 ** @student_block_size))
    group = 0
    ra.split('').each_with_index do |char, index|
      rectangle [50 + (@option_width + @horizontal_space_between_options)*char.to_i + group * (10 * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), 635 - index * (@option_height + @vertical_space_between_options)], @option_width, @option_height
      fill
      draw_text char, at: [50 - 12 + group * (10 * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), 635 - 6 - index * (@option_height + @vertical_space_between_options)], size: 8
    end
    draw_text student.name.split.map(&:mb_chars).map(&:capitalize).join(' '), at: [45, 725], width: 455, size: 12
    draw_text erp_code, at: [355, 677], width: 145, size: 12
  end

  def paint_exam_options exam_execution
    group = 0
    code = "%05d" % ((exam_execution.try(:exam).try(:code) || 0) % (10 ** @exam_block_size))
    code.split('').each_with_index do |char, index|
      rectangle [280 + (@option_width + @horizontal_space_between_options)*char.to_i + group * (10 * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), 630 - index * (@option_height + @vertical_space_between_options)], @option_width, @option_height
      fill
      draw_text char, at: [280 - 12 + group * (10 * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), 630 - 6 - index * (@option_height + @vertical_space_between_options)], size: 8
    end    
    text_box @full_name, at: [45, 710], width: 455, height: 20, overflow: :truncate, size: 12
    draw_text exam_execution.datetime.strftime('%d/%m/%Y'), at: [45, 677], size: 12
  end

  def paint_answers
    group = 0
    string_of_answers = @answers
    string_of_answers.split('').each_with_index do |char, index|
      next if char == '_'
      rectangle [150 + (@option_width + @horizontal_space_between_options)*(char.ord - 'A'.ord) + (index/50) * (5 * (@horizontal_space_between_options + @option_width) - @horizontal_space_between_options + @horizontal_space_between_groups), 560 - (index%50) * (@option_height + @vertical_space_between_options)], @option_width, @option_height
      fill
    end    
    draw_text @exam_execution.full_name, at: [45, 701], width: 455, size: 12
    draw_text @exam_execution.datetime.strftime('%d/%m/%Y'), at: [45, 677], size: 12
  end

end