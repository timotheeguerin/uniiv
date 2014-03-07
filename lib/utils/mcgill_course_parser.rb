require 'open-uri'
module Utils
  class McgillCourseParser

    def self.parse_course(url)
      hash = Utils::McgillCourseParser.parse_page(url)
      course = Course::Course.new
      course.name = hash[:name]
      course.subject = Course::Subject.find_by_name(hash[:subject])
      course.code = hash[:code]
      course.description = hash[:description]
      course.hours = hash[:hours]
      course.credit = hash[:credit]
      if course.subject.nil?
        return {:error => "Unknown subject `#{hash[:subject]}`, please add it first", :success => false, :unknown_subject => true, :subject => hash[:subject]}
      end

      if course.already_exist?
        return {:error => 'Already added', :success => false, :already_added => true}
      end
      unless course.save
        return {:error => "#{course.errors.full_messages}", :success => false}
      end
      requirement = Admin::CourseRequirementFilled.find_by_course_id(course.id)
      requirement.prerequisite_read=hash[:prerequisite].to_s
      requirement.corequisite_read=hash[:corequisite].to_s
      unless requirement.save
        return {:error => "#{requirement.errors.full_messages}", :success => false}
      end
      return {:course => course, :success => true}
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

    def self.parse_all
      page_nb = 0
      stats = {}
      stats[:parsed] = 0
      stats[:already_added] = 0
      stats[:unknown_subjects] = []
      stats[:errors] = []
      i = 0
      while true do
        url = "http://www.mcgill.ca/study/2013-2014/courses/search/?filters=language%3Aen%20sm_level%3AUndergraduate&solrsort=sort_title%20asc&page=#{page_nb}"
        page = Nokogiri::HTML(open(url))
        results = page.css('dl.search-results')[0]
        if results.nil? #Last page
          break
        end

        results.css('dt').each do |dt|
          i+=1
          href = dt.css('a')[0]['href']
          puts "#{i} Parsing #{href}"
          result = parse_course(href)
          if result[:success]
            stats[:parsed] += 1
          elsif result[:already_added]
            stats[:already_added] += 1
          elsif  result[:unknown_subject]
            stats[:unknown_subjects] << result[:subject]
          else
            stats[:errors] << result[:error]
          end
          puts href
        end
        page_nb +=1
      end
      stats
    end

  end
end