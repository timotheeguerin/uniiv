namespace :uniiv do
  namespace :courses do
    task :update_all => :environment do
      stats = Utils::McgillCourseParser.parse_all

      puts '====================='
      puts stats
    end
  end
end