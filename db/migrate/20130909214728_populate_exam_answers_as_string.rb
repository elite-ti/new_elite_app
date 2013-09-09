class PopulateExamAnswersAsString < ActiveRecord::Migration
  def up
    count = 0
    StudentExam.where("id < 100").each do |se|
      value = se.get_exam_answers.join('')
      if(value.length < 255)
        se.update_attribute(:exam_answers_as_string, value)
      end
      count += 1
      if count % 100 == 0
        p count
      end
    end
  end

  def down
    p 'ok'

  end
end
