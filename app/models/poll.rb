# encoding: UTF-8

class Poll < ActiveRecord::Base
  attr_accessible :name, :klazz_ids

  has_many :pdfs, dependent: :destroy
  has_many :klazzes, through: :pdfs
  has_many :questions, through: :pdfs
  has_many :answers, through: :questions

  validates :name, presence: true, uniqueness: true

  after_create :create_pdfs

  attr_writer :klazz_ids
  def klazz_ids
    @klazz_ids || klazzes.map(&:id)
  end

  def generate_zipfile
    string_io = Zip::ZipOutputStream::write_buffer do |zio|
      pdfs.each do |pdf|
        zio.put_next_entry("#{pdf.poll.name}_#{pdf.klazz.name}.pdf")
        zio.write PollPdf.new(pdf).render
      end
    end
    string_io.rewind

    string_io.sysread
  end

  def find_klazz(filename)
    extension = filename.split('.').last
    return 'Wrong extension. Must be a .dat.' unless ['dat', 'DAT'].include? extension

    klazz = klazzes.find_by_name(File.basename(filename, '.' + extension))
    return 'Klazz not found. Check filename.' if klazz.nil?

    return klazz
  end

  def update_answers(klazz, content)
    pdf = pdfs.select { |x| x.klazz_id == klazz.id }.first
    content.split("\n").each do |line|
      for i in 0..(line.size)
        question = pdf.questions.select { |x| x.number == i }.first
        grade = char_to_int(line[i])
        next if question.nil? || grade.nil?

        question.answers.create!(grade: grade)
      end
    end
  end

private

  def char_to_int(char)
    { 'A' => 5, 'B' => 4, 'C' => 3, 'D' => 2, 'E' => 1 }[char]
  end

  def create_pdfs
    self.klazz_ids = self.klazz_ids.map(&:to_i).select { |x| x > 0 }
    self.klazz_ids = Klazz.all.map(&:id) if self.klazz_ids.nil? || self.klazz_ids.empty?
    
    self.klazz_ids.map(&:to_i).each do |klazz_id|
      pdfs.create!(klazz_id: klazz_id) if klazz_id > 0
    end

    self.pdfs.each do |pdf|
      pdf.create_question('Opinião sobre a turma', 'Participação da turma')
      pdf.create_question('Opinião sobre a turma', 'Disciplina da turma')
      pdf.create_question('Opinião sobre a turma', 'Trabalho em equipe')

      pdf.create_question('Autoavaliação', 'Participação pessoal')
      pdf.create_question('Autoavaliação', 'Disciplina pessoal')

      pdf.klazz.teachers.uniq.each do |teacher|
        pdf.create_question('Professor', 'Conteúdo + Apresentação', teacher)
        pdf.create_question('Professor', 'Relacionamento', teacher)
        pdf.create_question('Professor', 'Disciplina', teacher)
      end
    end
  end
end
