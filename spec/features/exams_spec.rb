require 'spec_helper'

describe 'Exams' do
  QUESTION_CARDS = "#{Rails.root}/spec/support/"

  it 'uploads exams answers zip file, process and save data' do
    # log_admin_in
    # visit new_exam_answer_url
    # select 'Exam', from: 'Exam'
    # attach_file 'Zip or Rar', QUESTION_CARDS + 'all.zip'
    # click_button 'Create'
    # page.should have_content 'Exam answers were successfully uploaded.'
  end
end