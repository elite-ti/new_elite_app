class PollPdf < Prawn::Document
  def initialize(pdf)
    super(top_margin: 70)
    @pdf = pdf
    header
    create_table except_teachers_rows
    create_table teachers_rows
  end

private
  
  def header
    text "Poll #{@pdf.poll.name}", size: 30, style: :bold
    text "Klazz #{@pdf.klazz.name}", size: 30, style: :bold
  end

  def create_table(rows)
    move_down 20
    table rows do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def except_teachers_rows
    result = [["Tipo", "Categoria", "Numero", "Opiniao"]]
    except_teachers_questions.group_by(&:question_type).each do |key, value|
      result += row(key.name, value)
    end
    result
  end

  def except_teachers_questions
    pdf_questions.select { |x| x.question_type.name != 'Professor' }
  end

  def teachers_rows
    result = [["Professor", "Categoria", "Numero", "Opiniao"]]
    teachers_questions.group_by(&:teacher).each do |key, value|
      result += row(key.nickname, value)
    end
    result
  end

  def teachers_questions
    pdf_questions.select { |x| x.question_type.name == 'Professor' }
  end

  def pdf_questions
    @pdf_questions ||= @pdf.questions.
      includes(:question_type, :question_category, :teacher).
      sort { |x,y| x.number <=> y.number }
  end

  def row(first_column, questions)
    result = questions.map do |question|
      [question.question_category.name, question.number.to_s, 'a b c d e']
    end
    result[0].insert(0, make_cell(first_column, rowspan: questions.size))
    result
  end
end
