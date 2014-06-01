require 'open-uri'
module Utils
  class McgillCourseParser
    SubjectNotFound = Class.new(ActiveRecord::RecordNotFound)
    CourseAlreadyAdded = Class.new(StandardError)
    #Parse the course page of a mcgill course
    #@param url Mcgill website url of the course
    #@param update set to true to update a current course
    def self.load_course_from_url(url, update=true)
      hash = parse_page(url)
      course = course_from_hash(hash)

      fail SubjectNotFound, hash[:subject] if course.subject.nil?
      old_course = nil
      if course.already_exist?
        fail CourseAlreadyAdded, 'Already added!' if course.already_exist? and not update

        course, old_course = update_course(course)
      end
      course.save!
      requirement, old_requirement = update_course_requirement(course, hash)
      requirement.save!

      {:course => course, :old_course => old_course, :requirement => requirement, :old_requirement => old_requirement}
    end

    def self.update_course(new_course)
      course = Course::Course.find_by_subject_id_and_code(new_course.subject_id, new_course.code)
      old_course = course.dup
      course.assign_attributes :name => new_course.name,
                               :description => new_course.description,
                               :hours => new_course.hours,
                               :credit => new_course.credit

      return course, old_course
    end

    def self.update_course_requirement(course, hash)
      requirement = Admin::CourseRequirementFilled.find_by_course_id(course.id)
      old_requirement = requirement.dup
      requirement.prerequisite_read=hash[:prerequisite].to_s
      requirement.corequisite_read=hash[:corequisite].to_s
      return requirement, old_requirement
    end

    def self.parse_title(title, hash)
      text = title.split('(', 2)[0]
      credit = title.split('(', 2)[1]
      hash[:subject] = text.split(' ')[0]
      hash[:code] = text.split(' ')[1]
      hash[:name] = text.split(' ', 3)[2]
      if credit.nil?
        hash[:credit]=0
      else
        hash[:credit] = credit.split(' ')[0]
      end
      hash
    end

    def self.parse_additional_info(additional_info, hash)
      additional_info.each do |info|
        if info.text.start_with?('Prerequisite:') or info.text.start_with?('Prerequisites:')
          hash[:prerequisite] = info.text
        elsif info.text.start_with?('Corequisite:')
          hash[:corequisite] = info.text
        elsif info.text.match(/.* hours/)
          hash[:hours] = info.text
        end
      end
    end

    def self.course_from_hash(hash)
      course = Course::Course.new
      course.name = hash[:name]
      course.subject = Course::Subject.find_by_name(hash[:subject])
      course.code = hash[:code]
      course.description = hash[:description]
      course.hours = hash[:hours]
      course.credit = hash[:credit]
      course
    end

    def self.parse_page(url)
      hash = {}
      page = Nokogiri::HTML(open(url))
      container = page.css('#content-inner')[0]
      title = container.css('h1')[0].text

      parse_title(title, hash)
      content = container.css('#content-area .content')[0]
      hash[:description] = content.css('p')[0].text.split(':', 2)[1]
      list = content.css('ul')[0]
      unless  list.nil?
        additional_info = list.css('li')
        parse_additional_info(additional_info, hash)
      end
      hash[:hours] ||= 3
      hash
    end

    #Parse all the mcgill courses
    #@param update set to true to update a current course
    def self.parse_all(update = true)
      page_nb = 0
      stats = {}
      stats[:parsed] = 0
      stats[:already_added] = 0
      stats[:unknown_subjects] = []
      stats[:errors] = []
      i = 0
      while true do
        year = '2014-2015'
        url = "http://www.mcgill.ca/study/#{year}/courses/search/?filters=language%3Aen%20sm_level%3AUndergraduate&solrsort=sort_title%20asc&page=#{page_nb}"
        page = Nokogiri::HTML(open(url))
        results = page.css('dl.search-results')[0]
        if results.nil? #Last page
          break
        end
        puts '--------------------------------------------------------------'
        puts "\t\t\t PAGE #{page_nb}"
        puts '--------------------------------------------------------------'
        results.css('dt').each do |dt|
          i+=1
          href = dt.css('a')[0]['href']
          puts "##{i}\t #{href}"
          begin
            load_course_from_url(href, update)
            stats[:parsed] += 1
            puts "\t\t Course added"
          rescue SubjectNotFound => e
            stats[:unknown_subjects] << e.message
            puts "\t\t Unknown subject #{e.message}"
          rescue CourseAlreadyAdded
            stats[:already_added] += 1
            puts "\t\t Course already added"
          rescue => e
            stats[:errors] << "#{href} => #{e}"
            puts "\t\t Error #{e}"
          end
        end
        page_nb +=1
      end
      stats
    end

  end
end