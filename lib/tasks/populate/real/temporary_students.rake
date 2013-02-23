namespace :db do
  namespace :populate do
    namespace :real do 
      task temporary_students: :environment do
        p 'Creating temporary students'
        Campus.all.each do |campus|
          campus.products.each do |product|
            prefix = '9' + campus.code + product.code
            100.times do |i|
              temporary_ra = prefix + "%02d" % i
              p temporary_ra
            end            
          end
        end
      end
    end
  end
end
