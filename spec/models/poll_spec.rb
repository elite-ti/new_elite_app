# encoding: UTF-8

require 'spec_helper'

describe 'Poll' do
  it 'creates a poll and its pdfs' do
    set_poll_question_types_and_categories
    
    3.times { create :klazz }

    poll = build :poll
    poll.klazz_ids = Klazz.all.map(&:id)
    poll.save!

    Pdf.count.must.eq 3
  end

  def set_poll_question_types_and_categories
    ['Opinião sobre a turma', 'Autoavaliação', 'Professor'].each do |question_type_name|
      QuestionType.create!(name: question_type_name)
    end

    [
      'Participação da turma',
      'Disciplina da turma',
      'Trabalho em equipe',
      'Participação pessoal',
      'Disciplina pessoal',
      'Conteúdo + Apresentação',
      'Relacionamento',
      'Disciplina'
    ].each do |question_category_name|
      QuestionCategory.create!(name: question_category_name)
    end
  end
end