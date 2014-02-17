class Admin::Utils::CourseLoaderController < ApplicationController
  def new
    @url = ''
  end

  def load
    @url = params['url']
    if @url.nil?
      render :new
    else
      hash = Utils::McgillCourseParser.parse_page(@url)
      course = Course::Course.new
      course.name = hash[:name]
      course.subject = Course::Subject.find_by_name(hash[:subject])
      course.code = hash[:code]
      course.description = hash[:description]
      course.hours = hash[:hours]
      course.credit = hash[:credit]
      if course.subject.nil?
        flash[:notice] = "Unknown subject `#{hash[:subject]}`, please add it first"
        render 'new'
        return
      end
      unless course.save
        flash[:notice] = 'Course already added'
        render 'new'
        return
      end
      requirement = Admin::CourseRequirementFilled.find_by_course_id(course.id)
      requirement.prerequisite_read=hash[:prerequisite].to_s
      requirement.corequisite_read=hash[:corequisite].to_s
      unless requirement.save
        flash[:notice] = 'Error while saving the requirement readings'
      end
      puts 'p:' + requirement.prerequisite_read

      @course = course
      render :new
    end
  end
end
