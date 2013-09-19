# encoding: UTF-8

namespace :backup do
  task student_exams: :environment do
    Dir.glob("/home/deployer/apps/new_elite_app/shared/uploads/student_exam/card/**/original.tif") do |filename_std_exm|
      if (File.basename(File.dirname(File.dirname(filename_std_exm))) =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/) #check if is a number
        concat_dir_name = file File.basename(File.dirname(File.dirname(filename_std_exm))).to_i*1000+File.basename(File.dirname(filename_std_exm)).to_i
        `s3cmd put #{filename_std_exm} s3://elitesim.sistemaeliterio.com.br/apps/new_elite_app/shared/uploads/student_exam/card/#{concat_dir_name.to_s}/`
      else 
        dir_name = File.basename(File.dirname(filename_std_exm))
        `s3cmd put #{filename_std_exm} s3://elitesim.sistemaeliterio.com.br/apps/new_elite_app/shared/uploads/student_exam/card/#{dir_name.to_s}/`
      end
    end
  end
  
  task card_proc: :environment do
    Dir.glob("/home/deployer/apps/new_elite_app/shared/uploads/card_processing/file/**/*.*") do |filename_card_proc|
      dir_name_cp = File.basename(File.dirname(filename_card_proc))
      `s3cmd put #{filename_card_proc} s3://elitesim.sistemaeliterio.com.br/apps/new_elite_app/shared/uploads/card_processing/file/#{dir_name_cp.to_s}/`
    end
  end
end