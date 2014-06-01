
namespace :uniiv do

  task :before_task => :environment do
    if (verbose == true)
      Rails.logger.level = Logger::DEBUG
    else
      Rails.logger.level = Logger::INFO
    end
  end
  namespace :courses do
    task :update_all => :environment do
      stats = Utils::McgillCourseParser.parse_all

      puts '====================='
      puts stats
    end

    task :clean_requirement_flag => :environment do
      Rails.logger.info 'Cleaning course requirements'
      Admin::CourseRequirementFilled.includes(:course).load.each do |course_req|
          Rails.logger.debug { "Cleaning #{course_req.course}" }
        if course_req.prerequisite_read.nil? or course_req.prerequisite_read.blank?
          course_req.prerequisites = true
          Rails.logger.debug "\tEmpty prerequisite"
        end
        if course_req.corequisite_read.nil? or course_req.corequisite_read.blank?
          course_req.corequisites = true
          Rails.logger.debug "\tEmpty corequisite"
        end

        course_req.save
      end
    end
  end
end
current_tasks =  Rake.application.top_level_tasks
current_tasks.prepend 'uniiv:before_task'
Rake.application.instance_variable_set(:@top_level_tasks, current_tasks)