# encoding: UTF-8

namespace :profiler do
  task student_exam_scan: :environment do
    StudentExam.find(238928).scan
  end
end