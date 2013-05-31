# -*- coding: utf-8 -*-
class CardProcessing < ActiveRecord::Base

  has_paper_trail

  BEING_PROCESSED_STATUS = 'Being processed'
  PROCESSED_STATUS = 'Processed'
  ERROR_STATUS = 'Error'

  belongs_to :card_type
  belongs_to :campus
  has_many :student_exams, dependent: :destroy

  attr_accessible :card_type_id, :file, :is_bolsao, 
    :exam_date, :campus_id, :status, :name

  validates :campus_id, :card_type_id, :file, :name,
    :exam_date, :status, presence: true

  before_validation :set_default_attributes, on: :create
  mount_uploader :file, CardProcessingUploader

  def processed?
    status == PROCESSED_STATUS
  end

  def being_processed?
    status == BEING_PROCESSED_STATUS
  end

  def error?
    status == ERROR_STATUS
  end

  def processed!
    update_attribute :status, PROCESSED_STATUS
  end 

  def error!
    update_attribute :status, ERROR_STATUS
  end

  def needs_check?
    student_exams.needing_check.any?
  end

  def to_be_checked
    student_exams.needing_check.first
  end

  def total_number_of_cards
    student_exams.count
  end

  def number_of_errors
    student_exams.where(status: StudentExam::ERROR_STATUS).count +
      student_exams.where(status: StudentExam::NEEDS_CHECK).count +
      student_exams.where(status: StudentExam::REPEATED_STUDENT).count
  end

  def remove_file!
  end

  def excel_column(column)
    str = ''
    while column > 0
      if column%26 == 0
        str = 'Z' + str
        column = column/26 - 1
      else
        str = (column%26 - 1 + 'A'.ord).chr + str
        column = column/26
      end
    end
    str
  end

  def create_file
    subjects = ['Matemática', 20, 'Física', 15, 'Química', 10]
    student_exams = [[111111111,'nome do caboclinho com muitos caracteres para teste','unidade do caboclo',13,13,3],[111111111,'nome do caboclinho com muitos caracteres para teste','unidade do caboclo',13,13,3],[111111111,'nome do caboclinho com muitos caracteres para teste','unidade do caboclo',13,13,3],[111111111,'nome do caboclinho com muitos caracteres para teste','unidade do caboclo',13,1,3],[111111111,'nome do caboclinho com muitos caracteres para teste','unidade do caboclo',13,1,3],[111111111,'nome do caboclinho com muitos caracteres para teste','unidade do caboclo',3,1,3]]
    saving_path = "/home/elite/apps/beta/new_elite_app/downloads/#{@id}.xlsx"
    image_path = '/home/elite/apps/beta/new_elite_app/public/Logo Elite.jpg'

    p = Axlsx::Package.new  
    wb = p.workbook

    wb.styles do |s|

    #Styles
    title_style = s.add_style :font_name => "Verdana", :bg_color => "FFFFFF", :fg_color => "000000", :b => true, :sz => 20, :alignment => { :horizontal=> :center, :vertical => :center , :wrap_text => true}
    #header_style_top = s.add_style :border => { :style => :thick, :color =>"000000", :edges => [:top] }, :font_name => "Verdana", :bg_color => "CCCCCC", :fg_color => "000000", :b => true, :sz => 10, :alignment => { :horizontal=> :center, :vertical => :center , :wrap_text => true}
    #header_style_bottom = s.add_style :border => { :style => :thick, :color =>"000000", :edges => [:bottom] }, :font_name => "Verdana", :bg_color => "CCCCCC", :fg_color => "000000", :b => true, :sz => 10, :alignment => { :horizontal=> :center, :vertical => :center , :wrap_text => true}
    header_style = s.add_style :border => { :style => :thin, :color =>"000000", :edges => [:top, :right,:left, :bottom] }, :font_name => "Verdana", :bg_color => "CCCCCC", :fg_color => "000000", :b => true, :sz => 10, :alignment => { :horizontal=> :center, :vertical => :center , :wrap_text => true}
    blank_header_style = s.add_style :border => { :style => :thin, :color =>"000000", :edges => [:top, :right,:left, :bottom] }, :font_name => "Verdana", :bg_color => "CCCCCC", :fg_color => "000000", :b => true, :sz => 10, :alignment => { :horizontal=> :center, :vertical => :center , :wrap_text => true}
    line_style = s.add_style :border => { :style => :thin, :color =>"000000", :edges => [:top, :right,:left, :bottom] }, :font_name => "Verdana", :bg_color => "FFFFFF", :fg_color => "000000", :sz => 10, :alignment => { :vertical => :center , :wrap_text => false}
    

    wb.add_worksheet(:name => "#{@exam_date}") do |sheet|

      #https://github.com/randym/axlsx/blob/master/examples/example.rb  <-------------------------

          columns_count = 7 + subjects.size

          #add data
          sheet.add_row ['Turma'] + [''] * (columns_count - 1), :height => 34.5, :style => title_style
          sheet.add_row ["#{@exam_date}"] + [''] * (columns_count - 1), :height => 34.5, :style => title_style
          sheet.add_row ['ELITE'] + [''] * (columns_count - 1), :height => 34.5, :style => title_style

          subjects_header = []
          obj_header = []
          nota_header = []
          blank_header = ['-','-','-']

          Hash[*subjects].each do |key,value|
            subjects_header << key
            subjects_header << ''
            obj_header << 'Obj.'
            obj_header << ''
            nota_header << 'Ac.'
            nota_header << 'Nota'
            blank_header << "#{value}"
            blank_header << '-'
          end

          sheet.add_row ['Inscrição', 'Nome', 'Unidade'] + subjects_header + ['Média Total','Acertos Totais' , 'Clas.' , 'Pos.'], :style => header_style
          sheet.add_row ['', '', ''] + obj_header + ['','' , '' , ''], :style => header_style
          sheet.add_row ['', '', ''] + nota_header + ['','' , '' , ''], :style => header_style
          sheet.add_row blank_header + ['-','-','-','-'], :style => blank_header_style

          current_row = 7
          previous_med_value = 0
          student_exams.each do |student|
            current_row += 1
            row = [] + student[0..2]
            med_value = 0
            med_str = ''
            ac_str = '='
            for i in 1..(subjects.size/2)
              row << student[2+i]
              row << "=10*#{excel_column(2+2*i)}#{current_row}/#{excel_column(2+2*i)}7"

              ac_str = ac_str + "#{excel_column(2 + 2 * i)}#{current_row}+"
              med_str = med_str + "+#{excel_column(3 + 2 * i)}#{current_row}"
              med_value = med_value + student[2+i]
            end

            ac_str = ac_str[0..-2]
            med_value = med_value/(subjects.size/2)
            med_str = "=(#{med_str[1..-1]})/#{subjects.size/2}"

            row << med_str
            row << ac_str

            row << (current_row - 7)
            if previous_med_value == med_value
              row << sheet.rows[current_row-2].cells[row.size].value
            else
              row << (current_row - 7)
            end
            previous_med_value = med_value
            sheet.add_row row, :types => :string, :style => line_style
          end


          #Format
          #-Merge
          sheet.merge_cells("A1:#{excel_column(columns_count)}1")
          sheet.merge_cells("A2:#{excel_column(columns_count)}2")
          sheet.merge_cells("A3:#{excel_column(columns_count)}3")

          sheet.merge_cells("A4:A6")
          sheet.merge_cells("B4:B6")
          sheet.merge_cells("C4:C6")
          sheet.merge_cells("#{excel_column(columns_count-3)}4:#{excel_column(columns_count-3)}6")
          sheet.merge_cells("#{excel_column(columns_count-2)}4:#{excel_column(columns_count-2)}6")
          sheet.merge_cells("#{excel_column(columns_count-1)}4:#{excel_column(columns_count-1)}6")
          sheet.merge_cells("#{excel_column(columns_count)}4:#{excel_column(columns_count)}6")


          column_widths_array = [10,60,18]
          for i in 1..(subjects.size/2)
            column_widths_array << 4
            column_widths_array << 8.5
            sheet.merge_cells("#{excel_column(2+2*i)}4:#{excel_column(3+2*i)}4")
            sheet.merge_cells("#{excel_column(2+2*i)}5:#{excel_column(3+2*i)}5")
          end

          column_widths_array << 8
          column_widths_array << 8
          column_widths_array << 5.5
          column_widths_array << 5.5

          sheet.column_widths *(column_widths_array)

          img = File.expand_path(image_path, __FILE__)
          
          sheet.add_image(:image_src => img, :noSelect => true, :noMove => true) do |image|
            image.width = 120
            image.height = 120
            image.start_at 1, 0
          end

          sheet.auto_filter = "A7:#{excel_column(columns_count)}7"
          sheet.rows[6].hidden = true
          sheet.page_setup.fit_to :width => 1, :height => 1
      end
    end
    p.serialize(saving_path)
    saving_path
  end
  
private

  def set_default_attributes
    self.status = BEING_PROCESSED_STATUS
    self.is_bolsao ||= false
    true
  end
end
