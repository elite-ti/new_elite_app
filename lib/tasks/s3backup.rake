# encoding: UTF-8

namespace :backup do
  task student_exams: :environment do
    last_upload_se = File.open('/home/deployer/apps/new_elite_app/s3_backup_se_log.txt', &:readline).to_i
    last_upload_se_max = last_upload_se.to_i
    Dir.glob("/home/deployer/apps/new_elite_app/shared/uploads/student_exam/card/**/original.tif") do |filename_std_exm|
      if (File.basename(File.dirname(File.dirname(filename_std_exm))) =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/)
        concat_dir_name = File.basename(File.dirname(File.dirname(filename_std_exm))).to_i*10000+File.basename(File.dirname(filename_std_exm)).to_i
        if (concat_dir_name > last_upload_se)
          `s3cmd put #{filename_std_exm} s3://elitesim.sistemaeliterio.com.br/apps/new_elite_app/shared/uploads/student_exam/card/#{concat_dir_name.to_s}/`
          last_upload_se_max = [concat_dir_name, last_upload_se, last_upload_se_max].max
        end
      else
        if (dir_name > last_upload_se)
          dir_name = File.basename(File.dirname(filename_std_exm)).to_i
          `s3cmd put #{filename_std_exm} s3://elitesim.sistemaeliterio.com.br/apps/new_elite_app/shared/uploads/student_exam/card/#{dir_name.to_s}/`
          last_upload_se_max = [dir_name, last_upload_se, last_upload_se_max].max
        end
      end
    end
    File.open('/home/deployer/apps/new_elite_app/s3_backup_se_log.txt', 'w') {|clean| clean.truncate(0)}
    File.open('/home/deployer/apps/new_elite_app/s3_backup_se_log.txt', 'w') {|last| last.write(last_upload_se_max)}
  end
  
  task card_proc: :environment do
    last_upload_cp = File.open('/home/deployer/apps/new_elite_app/s3_backup_cp_log.txt', &:readline).to_i
    last_upload_cp_max = last_upload_cp.to_i
    Dir.glob("/home/deployer/apps/new_elite_app/shared/uploads/card_processing/file/**/*.*") do |filename_card_proc|
      dir_name_cp = File.basename(File.dirname(filename_card_proc)).to_i
      if (dir_name_cp > last_upload_cp)
        `s3cmd put #{filename_card_proc} s3://elitesim.sistemaeliterio.com.br/apps/new_elite_app/shared/uploads/card_processing/file/#{dir_name_cp.to_s}/`
        last_upload_cp_max = [dir_name_cp, last_upload_cp, last_upload_cp_max].max
      end
    end
    File.open('/home/deployer/apps/new_elite_app/s3_backup_cp_log.txt', 'w') {|clean| clean.truncate(0)}
    File.open('/home/deployer/apps/new_elite_app/s3_backup_cp_log.txt', 'w') {|last| last.write(last_upload_cp_max)}
  end
end