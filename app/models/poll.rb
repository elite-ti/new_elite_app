# encoding: UTF-8

class Poll < ActiveRecord::Base
  attr_accessible :name, :klazz_ids

  has_many :poll_pdfs, dependent: :destroy
  has_many :klazzes, through: :poll_pdfs
  has_many :poll_questions, through: :pdfs
  has_many :poll_answers, through: :poll_questions

  validates :name, presence: true, uniqueness: true

  after_create :create_pdfs

  attr_writer :klazz_ids
  def klazz_ids
    @klazz_ids || klazzes.map(&:id)
  end

  def generate_zipfile
    string_io = Zip::ZipOutputStream::write_buffer do |zio|
      poll_pdfs.each do |poll_pdf|
        zio.put_next_entry("#{poll_pdf.poll.name}_#{poll_pdf.klazz.name}.pdf")
        zio.write PollPdfPrawn.new(poll_pdf).render
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
    pdf = poll_pdfs.select { |x| x.klazz_id == klazz.id }.first
    content.split("\n").each do |line|
      for i in 0..(line.size)
        poll_question = poll_pdf.poll_questions.select { |x| x.number == i }.first
        grade = char_to_int(line[i])
        next if poll_question.nil? || grade.nil?

        poll_question.answers.create!(grade: grade)
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
      poll_pdfs.create!(klazz_id: klazz_id) if klazz_id > 0
    end

    self.poll_pdfs.each do |poll_pdf|
      poll_pdf.create_poll_question('Opinião sobre a turma', 'Participação da turma')
      poll_pdf.create_poll_question('Opinião sobre a turma', 'Disciplina da turma')
      poll_pdf.create_poll_question('Opinião sobre a turma', 'Trabalho em equipe')

      poll_pdf.create_poll_question('Autoavaliação', 'Participação pessoal')
      poll_pdf.create_poll_question('Autoavaliação', 'Disciplina pessoal')

      poll_pdf.klazz.teachers.uniq.each do |teacher|
        poll_pdf.create_poll_question('Professor', 'Conteúdo + Apresentação', teacher)
        poll_pdf.create_poll_question('Professor', 'Relacionamento', teacher)
        poll_pdf.create_poll_question('Professor', 'Disciplina', teacher)
      end
    end
  end
end
