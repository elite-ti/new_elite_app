# encoding: UTF-8

namespace :backup do
  task student_exams: :environment do
#      "~/apps/new_elite_app/shared/uploads/student_exam/card/"
    Dir.glob("/Users/PG/Documents/direito/leis/artigos/**/*.tif") do |filename|
      if (File.basename(File.dirname(File.dirname(filename))) =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/) #check if is a number
        p File.basename(File.dirname(File.dirname(filename))).to_i*1000+File.basename(File.dirname(filename)).to_i
        # p File.dirname(File.dirname(filename))
        # `cp -a #{filename} #{File.dirname(File.dirname(filename)).to_i*1000+File.dirname(filename).to_i}`
      else 
        p File.basename(File.dirname(filename)).to_i
        p File.dirname(filename)
        p File.dirname(File.dirname(filename))
       `cp -P ~/Documents/apps/new_elite_app/shared/uploads/student_exam/card/#{File.basename(File.dirname(filename)).to_i} `
      end
      # student_exam_id = 
      # `s3cmd put --acl-private --recursive ~/apps/new_elite_app/shared/uploads/student_exam/card/#{File.basename(File.dirname(File.dirname(filename)))} s3://elitesim.sistemaeliterio.com.br/apps/new_elite_app/shared/uploads/student_exam/card/#{File.basename(File.dirname(File.dirname(filename)))}`
    # filename = File.basename("~/apps/new_elite_app/shared/uploads/student_exam/card/",)
    # if(filename = "original.tif")      
    end
  end
end