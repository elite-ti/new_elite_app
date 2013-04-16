# encoding: UTF-8

namespace :super_klazz do
  task create_attendance_list: :environment do
    p 'Creating attendance list'

    folder = '/home/charlie/Desktop/attendance'
    SuperKlazz.includes(:campus, product_year: :product).all.each do |super_klazz|
      uri = "#{super_klazz.campus.name}_#{super_klazz.product_year.product.name}.csv"
      uri.gsub!(/\//, '-')

      CSV.open("#{folder}/" + uri, "wb") do |csv|
        super_klazz.enrolled_students.each do |student|
          csv << [student.ra, student.name]
        end
      end

      # prefix = '9' + campus.code + product.code
      # uri = "#{campus.name}_#{product.name}_temporary.csv"
      # uri.gsub!(/\//, '-')
      # CSV.open("#{desktop}/" + uri, "wb") do |csv|
      #   80.times do |i|
      #     temporary_ra = prefix + "%02d" % i
      #     csv << [temporary_ra]
      #   end
      # end
    end
  end

  task create_exam_results: :environment do 
    p 'Creating exam results'
    result_date = '2013-04-06'
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    valid_card_processing_ids.delete(234)
    count = 1
    total = StudentExam.where(status: 'Valid', card_processing_id: valid_card_processing_ids).size
    CSV.open("/home/deployer/results/exam_results_#{result_date}.csv", "wb") do |csv|
      StudentExam.includes(
        :student, 
        exam_answers: :exam_question, 
        exam_execution: { super_klazz: [:campus, product_year: :product]}
      ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).each do |student_exam|
        p student_exam.id.to_s + '(' + count.to_s + ' of ' + total.to_s + ')'
        count += 1
        csv << [
          student_exam.student.ra, 
          student_exam.student.name, 
          student_exam.exam_execution.super_klazz.product_year.product.name,
          student_exam.exam_execution.super_klazz.campus.name,
          student_exam.get_exam_answers.join(''),
          student_exam.string_of_answers
        ]
      end
    end
  end

  task test_student_exams: :environment do
    result_date = '2013-04-06'
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    warnings = []
    StudentExam.includes(
    :student,
    exam_answers: :exam_question,
    exam_execution: { super_klazz: [:campus, product_year: :product]}
    ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).each do |student_exam|
      p student_exam.id
      last = student_exam.string_of_answers.rindex(/[ABCDE]/)
      if last.nil?
        last = -1
      end
      if (last + 1 - student_exam.exam_execution.exam.exam_questions.size).abs > 3
      warnings << student_exam
      end
    end

    if warnings.length > 0
      p 'Please check the following Student Exams: ';
      pp warnings.map{|se| "http://elitesim.sistemaeliterio.com.br/student_exams/" + se.id.to_s + " - " + se.exam_execution.exam_cycle.product_year.name};
    else
      p 'No warnings. Moving on.';
    end
  end

  task check_student_exams: :environment do
    result_date = '2013-04-06'

    p 'Creating exam results for ' + result_date.to_s
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    errors = StudentExam.where(card_processing_id: valid_card_processing_ids).select {|se| se.status != 'Valid'}.size

    if errors > 0
    p 'There are still #{errors} errors. Press any key to continue.'
    answer = gets.chomp
    else
    p 'Ok, no errors. Moving on.'
    end    
  end

  task create_separated_exam_results: :environment do
    result_date = '2013-03-23'

    p 'Creating exam results for ' + result_date.to_s
    valid_card_processing_ids = CardProcessing.where(exam_date: result_date).map(&:id)
    errors = StudentExam.where(card_processing_id: valid_card_processing_ids).select {|se| se.status != 'Valid'}.size

    if errors > 0
    p 'There are still #{errors} errors. Press any key to continue.'
    else
    p 'Ok, no errors. Moving on.'
    end

    warnings = []
    StudentExam.includes(
    :student,
    exam_answers: :exam_question,
    exam_execution: { super_klazz: [:campus, product_year: :product]}
    ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).each do |student_exam|
      p student_exam.id
      last = student_exam.string_of_answers.rindex(/[ABCDE]/)
      if last.nil?
        last = -1
      end
      if (last + 1 - student_exam.exam_execution.exam.exam_questions.size).abs > 3
      warnings << student_exam
      end
    end

    if warnings.length > 0
      p 'Please check the following Student Exams: ' + warnings.map(&:id).join(', ')
    else
      p 'No warnings. Moving on.'
    end

    lists = {"Pré-Vestibular" => [], "9º Ano Forte - 2013"=> [], "9º Ano Militar - 2013"=> [], "1ª Série Militar - 2013"=> [], "2ª Série Militar - 2013"=> [], "AFA/EAAr/EFOMM - 2013"=> [], "AFA/ESPCEX - 2013"=> [], "IME-ITA - 2013"=> [], "AFA/EN/EFOMM - 2013"=> []}
    translation = {"Pré-Vestibular Manhã - 2013" => "Pré-Vestibular", "9º Ano Forte - 2013" => "9º Ano Forte - 2013", "Pré-Vestibular Noite - 2013" => "Pré-Vestibular", "9º Ano Militar - 2013" => "9º Ano Militar - 2013", "1ª Série Militar - 2013" => "1ª Série Militar - 2013", "2ª Série Militar - 2013" => "2ª Série Militar - 2013", "AFA/EAAr/EFOMM - 2013" => "AFA/EAAr/EFOMM - 2013", "AFA/ESPCEX - 2013" => "AFA/ESPCEX - 2013", "Pré-Vestibular Biomédicas - 2013" => "Pré-Vestibular", "3ª Série + Pré-Vestibular Manhã - 2013" => "Pré-Vestibular", "IME-ITA - 2013" => "IME-ITA - 2013", "3ª Série + IME-ITA - 2013" => "IME-ITA - 2013", "AFA/EN/EFOMM - 2013" => "AFA/EN/EFOMM - 2013", "3ª Série + AFA/ESPCEX - 2013" => "AFA/ESPCEX - 2013", "3ª Série + Pré-Vestibular Biomédicas - 2013" => "Pré-Vestibular"}

    StudentExam.includes(
      :student,
      exam_answers: :exam_question,
      exam_execution: { super_klazz: [:campus, product_year: :product]}
    ).where(status: 'Valid', card_processing_id: valid_card_processing_ids).each do |student_exam|
      lists[translation[student_exam.exam_execution.exam_cycle.product_year.name]] << [
        student_exam.student.ra,
        student_exam.student.name,
        student_exam.exam_execution.super_klazz.product_year.product.name,
        student_exam.exam_execution.super_klazz.campus.name,
        student_exam.get_exam_answers.join(''),
        student_exam.string_of_answers
      ]
    end

    Dir.mkdir("/home/deployer/results/exam_results_#{result_date}/")
    lists.keys.sort.each do |key|
      puts "Building #{key} file..."
      CSV.open("/home/deployer/results/exam_results_#{result_date}/#{key}.csv", "wb") do |csv|
        lists[key].each do |item|
          csv << item
        end
      end
    end

    pp 'Run the following command to convert: iconv -f utf-8 -t windows-1252 /home/deployer/results/exam_results_2013-03-23.csv > /home/deployer/results/exam_results_2013-03-23_ansi.csv'
    pp 'Convert all files to windows-1252 and run the following command on local machine:\n scp deployer@elitesim.sistemaeliterio.com.br:/home/deployer/results/exam_results_#{result_date}_ansi.csv ~/Elite/resultados/exam_results_#{result_date}_ansi.csv'

  end
end
