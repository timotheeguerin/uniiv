class CourseRecommendationEngine
  def self.compute_recommendations(scenario)
    user = scenario.user
    #user.course_recommendations.destroy_all
    courses_scores = {}
    merge(courses_scores, compute_program_recommendation(scenario))
  end


  def merge(hash1, hash2)
    hash1.merge!(hash2) do |key, old, new|
      old+new
    end
  end

  #Compute the show of recommended courses using the program of the users
  def self.compute_program_recommendation(scenario)
    user = scenario.user
    courses_scores = {}
    user.programs.each do |program|
      program.groups.each do |group|
        case group.restriction.name
          when :all
            group.courses.each do |course|
              courses_scores[course] ||= 0
              courses_scores[course] += Coefficient::COURSE_REQUIRED
            end
          when :min_credit
            unless group.completed?(scenario, :planning => true)
              group.courses.each do |course|
                courses_scores[course] ||= 0
                courses_scores[course] += Coefficient::COURSE_CHOICE
              end
            end
        end
      end
    end
  end

  #Compute the show of recommended courses using the courses taken/completed
  #by other user in the same program as you
  def self.compute_popular_in_programs(scenario)
    user - scenario.user
    courses_scores = {}
    user.programs.each do |program|
      courses_count = []
      program.users.each do |user_in_program|
        user_in_program.completed_courses.each do |course|
          courses_count[course.course] ||= 0
          courses_count[course.course] += 1
        end
      end
      courses_count.each do |course, count|
        courses_scores[course] ||= 0
        courses_scores[course] += count / program.users.size * Coefficient::COURSE_OTHER_USER_TAKING
      end
    end
    courses_scores
  end


  def self.compute_most_popular_courses
    UserCompletedCourse.count(:group => 'course').order(:count)
  end


end

module Coefficient
  COURSE_REQUIRED = 10
  COURSE_CHOICE = 3
  COURSE_OTHER_USER_TAKING = 3
end