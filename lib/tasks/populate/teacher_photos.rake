namespace :db do
  namespace :populate do
    # Set this path to where you saved teachers photos
    PHOTOS_PATH = '/home/charlie/Dropbox/projects/elite/new_elite_app/teacher_photos'
    JPG_EXT = '.jpg'

    task teacher_photos: :environment do
      p 'Storing teacher_photos to database'
      Dir.foreach(PHOTOS_PATH) do |filename|
        next if File.extname(filename) != JPG_EXT
        employee = Employee.find_by_elite_id!(File.basename(filename, JPG_EXT))
        employee.photo.store!(File.open(File.join(PHOTOS_PATH)))
        employee.save!
      end
    end
  end
end