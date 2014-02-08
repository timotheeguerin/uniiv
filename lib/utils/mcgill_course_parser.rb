require 'open-uri'
module Utils
  class McgillCourseParser

    def self.parse_title(title, hash)
      text = title.split('(', 2)[0]
      credit = title.split('(', 2)[1]
      hash[:subject] = text.split(' ')[0]
      hash[:code] = text.split(' ')[1]
      hash[:name] = text.split(' ', 3)[2]
      hash[:credit] = credit.split(' ')[0]
      hash
    end

    def self.parse_additional_info(additional_info, hash)
      additional_info.each do |info|
        if info.text.start_with?('Prerequisite:')
          hash[:prerequisite] = info.text
        elsif info.text.start_with?('Corequisite:')
          hash[:corequisite] = info.text
        elsif info.text.match(/.* hours/)
          hash[:hours] = info.text
        end
      end

      hash[:hours] ||= 3

    end

    def self.parse_page(url)
      hash = {}
      page = Nokogiri::HTML(open(url))
      container = page.css('#content-inner')[0]
      title = container.css('h1')[0].text

      parse_title(title, hash)
      content = container.css('.content')[0]

      hash[:description] = content.css('p')[0].text.split(':', 2)[1]
      additional_info = content.css('ul')[0].css('li')
      parse_additional_info(additional_info, hash)
      hash
    end

  end
end