# encoding: UTF-8

namespace :backup do
  task student_exams: :environment do
    if File.exist?('/home/deployer/apps/new_elite_app/s3_backup_se_log.txt')
      last_upload_se = `tail -n 1 /home/deployer/apps/new_elite_app/s3_backup_se_log.txt`
    else
      last_upload_se = File.open('/home/deployer/apps/new_elite_app/s3_backup_se_log.txt',"w"){}
    end
    last_se_id = (last_upload_se.split(',')[0]).split(' ')[1].to_i
    new_std_exms = StudentExam.where("id > #{last_se_id}").sort
    new_std_exms.each do |std_exm|
      card = std_exm.card
      folder = ("%09d" % std_exm.id).to_s.scan(/.../)
      filename_se = File.basename(std_exm.card.to_s)
      p "id: " + std_exm.id.to_s + ", card: student_exam/" + folder[0] + "/" + folder[1] + "/" + folder[2] + "/" + filename_se
      p = "id: " + std_exm.id.to_s + ", card: student_exam/" + folder[0] + "/" + folder[1] + "/" + folder[2] + "/" + filename_se + "\n"
      File.open('/home/deployer/apps/new_elite_app/s3_backup_se_log.txt', 'a') {|log| log.write(p)}
    end
  end
  
  task card_proc: :environment do
    if File.exist?('/home/deployer/apps/new_elite_app/s3_backup_cp_log.txt')
      last_upload_cp = `tail -n 1 /home/deployer/apps/new_elite_app/s3_backup_cp_log.txt`
    else
      last_upload_cp = File.open('/home/deployer/apps/new_elite_app/s3_backup_cp_log.txt',"w"){}
    end
    last_cp_id = (last_upload_cp.split(',')[0]).split(' ')[1].to_i
    new_card_procs = CardProcessing.where("id > #{last_cp_id}").sort
    new_card_procs.each do |card_proc|
      file = card_proc.file
      folder = ("%06d" % card_proc.id).to_s.scan(/.../)
      filename_cp = File.basename(card_proc.file.to_s)
      `s3cmd put /home/deployer/apps/new_elite_app/shared#{file} s3://elitesim.sistemaeliterio.com.br/card_processing/#{folder[0]}/#{folder[1]}/`
      p "id: " + card_proc.id.to_s + ", file: card_processing/" + folder[0] + "/" + folder[1] + "/" + filename_cp
      p = "id: " + card_proc.id.to_s + ", file: card_processing/" + folder[0] + "/" + folder[1] + "/" + filename_cp + "\n"
      File.open('/home/deployer/apps/new_elite_app/s3_backup_se_log.txt', 'a') {|log| log.write(p)}
    end
  end
end