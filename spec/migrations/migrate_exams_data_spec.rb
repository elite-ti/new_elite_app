require 'spec_helper'
require_relative '../../db/migrate/20130312180113_migrate_exams_data.rb'

describe MigrateExamsData do
	it 'tests get_subject_answers_hash_from method' do 

		exam = create :exam, correct_answers: 'AAABBB'
		math = create :subject
		math_topic = create :topic, subject_id: math.id
		english = create :subject
		english_topic = create :topic, subject_id: english.id

		exam.questions.each do |question|
			if question.correct_options.first.letter == 'A'
				question.topic_ids = [math_topic.id]
			else 
				question.topic_ids = [english_topic.id]
			end
		end

		med = MigrateExamsData.new
		med.get_subject_answers_hash_from(exam).should == {
			math => 'AAA',
			english => 'BBB'
		}
	end
end