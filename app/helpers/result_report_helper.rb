require 'axlsx'

module ResultReportHelper

  def self.exam_execution_report(titles, headers, output)
    pkg = Axlsx::Package.new
    wb = pkg.workbook
    wb.styles do |s|
      s.fonts.first.name = 'Verdana'
      title_cell = s.add_style :bg_color => "FFFFFF", :fg_color => "000000", :sz => 20, :alignment => { horizontal: :center }, b: true
      header_cell = s.add_style  :bg_color => "8B8B8B", :fg_color => "000000", :sz => 10, :alignment => { :horizontal=> :center }, :border => { :style => :thin, :color => "00" }, b: true
      content_cell = s.add_style  :bg_color => "FFFFFF", :fg_color => "000000", :sz => 10, :alignment => { :horizontal=> :center }, :border => { :style => :thin, :color => "00" }
      ra_cell = s.add_style :bg_color => "FFFFFF", :fg_color => "000000", :sz => 10, :alignment => { :horizontal=> :center }, :border => { :style => :thin, :color => "00" }, :format_code => "000000"
      name_campus_cell = s.add_style :bg_color => "FFFFFF", :fg_color => "000000", :sz => 10, :alignment => { :horizontal=> :left }, :border => { :style => :thin, :color => "00" }
      hits_cell = s.add_style :bg_color => "FFFFFF", :fg_color => "000000", :sz => 10, :alignment => { :horizontal=> :center }, :border => { :style => :thin, :color => "00" }
      grade_cell = s.add_style :bg_color => "FFFFFF", :fg_color => "000000", :sz => 10, :alignment => { :horizontal=> :center }, :border => { :style => :thin, :color => "00" }, :format_code => "0.00"
      general_grade_cell = s.add_style :bg_color => "FFFFFF", :fg_color => "000000", :sz => 10, :alignment => { :horizontal=> :center }, :border => { :style => :thin, :color => "00" }, :format_code => "0.000"
      wb.add_worksheet(name: 'Resultado') do |sheet|
        row_number = 1
        index_hash = Hash.new {|hash,key| hash[key] = hash[key - 1].next }.merge({0 => "A"})
        titles.each do |row|
          sheet.add_row row, style: title_cell
          sheet.merge_cells "A#{row_number}:#{index_hash[headers.size-1]}#{row_number}"
          row_number = row_number + 1
        end    
        sheet.add_row headers, style: header_cell
        output.each do |row|
          sheet.add_row row, style: content_cell
        end
        sheet.column_widths *([9, 56, 17] + (3..headers.size-3).map{|i| 7} + [10, 10])
        sheet.col_style 0, ra_cell, :row_offset => 4
        sheet.col_style 1, name_campus_cell, :row_offset => 4
        sheet.col_style 2, name_campus_cell, :row_offset => 4
        (3..headers.size-3).each do |i|
          if i % 2 == 1
            sheet.col_style i, hits_cell, :row_offset => 4
          else
            sheet.col_style i, grade_cell, :row_offset => 4
          end
        end
        sheet.col_style headers.size-1, general_grade_cell, :row_offset => 4
        img = "#{Rails.root}/app/assets/images/elite-logo-bw.png"
        sheet.add_image(:image_src => img) do |image|
          image.width = 100
          image.height = 100
          image.start_at 0, 0
        end
      end
    end

    pkg.to_stream.read
  end
end