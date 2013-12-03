#encoding: UTF-8

require 'prawn'
# require 'gchart'

class TeachingAssistantPrawn < Prawn::Document
  def initialize(type, row, specific_rows, image_folder)
    super(page_size: "A4", page_layout: :portrait, top_margin: 40)
    p row
    p specific_rows
    p specific_rows.map{|s| s['Unidade']}
    @row = row
    @type = type
    @specific_rows = specific_rows
    @image_folder = image_folder
    if !["Monitor", "Instrutor"].include? @type
      return nil
    end
    set_default_parameters
    header
    content
  end

private
  def set_default_parameters
    font "Helvetica"
    self.line_width = 0.1
  end

  def header
    text "Avaliação dos #{@type}es 2013", size: 24, style: :bold, :align => :center
    move_down 10
    text (@row[:concat_1] || @row[:concat] || 'Sem nome'), size: 20, style: :bold, :align => :center
    image "#{File.join(Rails.root, 'app/assets/images/elite-logo.png')}", at:[10, 770], fit: [70, 70]
  end

  def content
    move_down 20
    # First Area
    image main_chart, at:[10, 670], fit: [384, 240]
    legend
    general_grade
    image picture_filepath, at:[414, 580], fit: [106, 150]
    # Last Area
    if @type == "Monitor"
      image mini_chart(0), at:[200, 415], fit: [384, 150] if @specific_rows.size > 0
      image mini_chart(1), at:[10, 415], fit: [384, 150] if @specific_rows.size > 1
      image mini_chart(2), at:[390, 415], fit: [384, 150] if @specific_rows.size > 2
      move_down 380
    elsif @type == "Instrutor"
      move_down 300
      table([[{:content => "Categorias", :rowspan => 2}, {:content => "Unidades", :colspan => @specific_rows.size}, {:content => "Média", :rowspan => 2}],@specific_rows.map{|s| s['Unidade']}, (['Conteúdo + Apresentação'] + @specific_rows.map{|s| s['Conteúdo+Apresentação']} + ["%.2f" % (@specific_rows.map{|s| s['Conteúdo+Apresentação'].to_f}.inject(:+).to_f/@specific_rows.size)]), (['Relacionamento'] + @specific_rows.map{|s| s['Relacionamento']} + ["%.2f" % (@specific_rows.map{|s| s['Relacionamento'].to_f}.inject(:+).to_f/@specific_rows.size)]), (['Disciplina'] + @specific_rows.map{|s| s['Disciplina']} + ["%.2f" % (@specific_rows.map{|s| s['Disciplina'].to_f}.inject(:+).to_f/@specific_rows.size)])], :position => :center, :header => true, cell_style: {:height => 18, :size => 9.5, :align => :center}) do |tbl|
        tbl.row(0).font_style = :bold
        tbl.row(0).align = :center
        tbl.row(0).valign = :center
        tbl.row(0).background_color = 'D0D0D0'
        tbl.row(1).background_color = 'D0D0D0'
        tbl.row(1).font_style = :bold
        tbl.row(1).align = :center
        tbl.row(1).valign = :center
        # tbl.row(0)[0].vertical_padding = 5
      end
    end
    move_down 170    
    # Comments Area
    if !@row[:comentrio_1].nil? || !@row[:comentrio_2].nil?
      text_box 'Comentários:', at: [10, 250], size: 14, align: :left
    end
    if !@row[:comentrio_1].nil?
      stroke_rectangle [10, 230], 510, 45
      text_box @row[:comentrio_1], at: [15, 225], size: 12, width: 505, align: :left
    end
    if !@row[:comentrio_2].nil?
      stroke_rectangle [10, 175], 510, 45
      text_box @row[:comentrio_2], at: [15, 170], size: 12, width: 505, align: :left
    end      
    # Footer
    move_down 30
    table([['Critérios para Medição de Conceito'], ['A = Os 20% dos monitores com as melhores notas.'], ['B = Os 35% dos monitores posteriores.'], ['C = Os 35% dos monitores posteriores.'], ['D = Os 10% dos monitores restantes.']], :header => true, column_widths: [250], cell_style: {:height => 18, :size => 9.5}) do |tbl|
      tbl.row(0).font_style = :bold
      tbl.row(0).align = :left
      # tbl.row(0).background_color = 'D0D0D0'
    end      
  end

  def general_grade
    text_box @row[:conceito], at: [414, 660], size: 60, width: 100, align: :center
    text_box 'Conceito', at: [414, 605], size: 12, width: 106, align: :center
    stroke_rectangle [414, 670], 106, 80    
  end

  def legend
    rectangle [342, 618], 5, 2
    fill_color "00FF00"
    fill
    rectangle [342, 608], 5, 2
    fill_color "FFFF00"
    fill
    rectangle [342, 598], 5, 2
    fill_color "FF0000"
    fill
    fill_color "888888"
    text_box 'Excelente', at: [352, 620], size: 7
    text_box 'Bom', at: [352, 610], size: 7
    text_box 'Insuficiente', at: [352, 600], size: 7
    fill_color "000000"    
  end

  def main_chart
    # teacher_assistant = [4.5, 4, 4.5, 4, 3.9, 5, 4.3, 4.6, 4.2]
    
    if @type == 'Instrutor'
      average = [3.8, 3.7, 5, 3.7, 3.6, 4.6, 4.7]
      titles = "Cont+Apres.|Relacion.|Vestua.|Pró-Ativid.|Discipl.|Assiduid.|Pontual."
      bar_width_and_spacing = [25,0,25]
      teacher_assistant = [
        @row[:contedoapresentao], # => Cont+Apres.
        @row[:relacionamento_interpessoal], # => Relacion.
        @row[:vesturio], # => Vestua.
        @row[:pratividade], # => Pró-Ativid.
        @row[:disciplina], # => Discipl.
        @row[:assiduidade], # => Assiduid.
        @row[:pontualidade] # => Pontual.
      ]
    else
      average = [4.0, 3.8, 4.9, 3.8, 4.2, 3.8, 4.7, 4.8]
      titles = "Cont+Apres.|Relacion.|Vestua.|Pró-Ativid.|Discipl.|Comport.|Assiduid.|Pontual."
      bar_width_and_spacing = [25,0,15]
      teacher_assistant = [
        @row[:contedoapresentao], # => Cont+Apres.
        @row[:relacionamento_interpessoal], # => Relacion.
        @row[:vesturio], # => Vestua.
        @row[:pratividade], # => Pró-Ativid.
        @row[:disciplina], # => Discipl.
        @row[:comportamento], # => Comport.
        @row[:assiduidade], # => Assiduid.
        @row[:pontualidade] # => Pontual.
      ]
    end



    bar_chart = Gchart.new(
                :type => 'bar',
                :size => '640x400',
                :bar_colors => ['000000', '888888'],
                :title => "GRÁFICO COMPARATIVO CATEGORIA",
                :bg => 'FFFFFF',
                :legend => ['Sua Média', 'Média Geral'],
                :data => [teacher_assistant, average],
                :filename => main_image_filepath,
                :stacked => false,
                :axis_with_labels => [['x'], ['y']],
                :max_value => 5,
                :min_value => 1,
                :axis_labels => [[],["1|1.5|2|2.5|3|3.5|4|4.5|5"]],
                :axis_labels => [[titles],["1|1.5|2|2.5|3|3.5|4|4.5|5"]],
                :bar_width_and_spacing => bar_width_and_spacing,
                :custom => 'chls=3,1,0&chg=200,12.5,1,4&chm=h,FF0000,0,0.25,3|h,FFFF00,0,0.625,3|h,00FF00,0,1,3|N*1*,000000,0,-1,11|N*1*,000000,1,-1,11&chds=1,5'
                )
    bar_chart.file
    main_image_filepath
  end

  def mini_chart index
    teacher_assistant = [
      (@specific_rows[index]["Conteúdo+Apresentação"] || @specific_rows[index]["Conteúdo"] || "0").to_f,
      (@specific_rows[index]["Relacionamento1"] || @specific_rows[index]["Relacionamento2"] || "0").to_f,
      (@specific_rows[index]["Disciplina"] || @specific_rows[index]["Comportamento"] || "0").to_f
    ]
    title = @specific_rows[index]["Avaliação"]
    if @specific_rows[index]["Avaliação"] == 'Plantão de Dúvidas'
      fields = "Cont+Apres.|Relacion.|Comport."
    else
      fields = "Cont+Apres.|Relacion.|Discipl." 
    end

    bar_chart = Gchart.new(
                :type => 'bar',
                :size => '400x400',
                :bar_colors => ['000000'],
                :title => title,
                :bg => 'FFFFFF',
                :data => [teacher_assistant],
                :filename => mini_image_filepath(index),
                :stacked => false,                # :legend_position => 'bottom',
                :axis_with_labels => [['x'], ['y']],
                :max_value => 5,
                :min_value => 1,                
                :axis_labels => [[fields], ["1|1.5|2|2.5|3|3.5|4|4.5|5"]],
                :bar_width_and_spacing => [40,0,40],
                :custom => 'chls=3,1,0&chg=200,12.5,1,4&chm=N*1*,000000,0,-1,11&chds=1,5'
                )
    bar_chart.file
    mini_image_filepath index
  end

  def main_image_filepath
    File.join(@image_folder, (@row[:nome_professor] || 'Sem nome') + '_main.png')
  end

  def mini_image_filepath index
    File.join(@image_folder, (@row[:nome_professor] || 'Sem nome') + '_mini' + index.to_s + '.png')
  end

  def picture_filepath
    if File.exists?("/Users/pauloacmelo/Code/charts_sandbox/fotos/#{(@row[:nome_professor] || 'Sem nome')}.jpg")
      "/Users/pauloacmelo/Code/charts_sandbox/fotos/#{(@row[:nome_professor] || 'Sem nome')}.jpg"
    elsif File.exists?("/Users/pauloacmelo/Code/charts_sandbox/fotos/#{(@row[:nome_professor] || 'Sem nome')}.png")
      "/Users/pauloacmelo/Code/charts_sandbox/fotos/#{(@row[:nome_professor] || 'Sem nome')}.png"
    else
      p "sem foto"
      "/Users/pauloacmelo/Code/charts_sandbox/fotos/Sem nome.jpg"
    end
  end
end