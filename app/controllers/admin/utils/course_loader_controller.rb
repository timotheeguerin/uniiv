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
      course.save

      requirement = Admin::CourseRequirementFilled.new
      requirement.course = course
      requirement.prerequisite_read=hash[:prerequisite]
      requirement.corequisite_read=hash[:corequisite]
      requirement.prerequisites = false
      requirement.corequisites = false
      requirement.save
      @course = course
      render :new
    end
  end
end
