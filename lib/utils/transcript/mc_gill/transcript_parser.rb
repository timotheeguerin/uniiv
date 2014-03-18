module Utils::Transcript
  module McGill
    class TranscriptParser
      attr_accessor :html
      attr_accessor :records

      def self.parse(html)
        transcript = TranscriptParser.new(html)
        transcript.parse_html
        transcript
      end

      def initialize(html)
        @html = html
        @university = University.find_by_name('McGill University')
      end

      def parse_html
        records = []
        document = Nokogiri::HTML(@html)
        rows = document.search("table[@class='dataentrytable'] tr")
        last_term=nil
        rows.each do |row|
          row_data = row.search('td')
          term = extract_semester(row_data)
          unless term.nil?
            last_term = term
          end
          next if last_term.nil?
          next unless record_data_row?(row_data) && grade_present?(row_data)


          records << extract_record(row_data, last_term)
        end
        @records = records
      end

      def index_for(name)
        case name
          when :number then
            1
          when :section then
            2
          when :name then
            3
          when :credits then
            4
          when :grade then
            6
          when :average then
            10
        end
      end

      def extract_semester(data)
        span = data[0].search('span > b')
        if span and span.text.match /^(FALL|WINTER|SUMMER)|[0-9]+$/
          Utils::Term.from_string(span.text)
        else
          nil
        end
      end

      def extract_record_data_for(data, name)
        index = index_for(name)

        if data && data[index]
          span = data[index].search('span')

          if span
            span.text
          else
            ''
          end
        end
      end

      def record_data_row?(row_data)
        row_data.length == 11
      end

      def grade_present?(row_data)
        grade = extract_record_data_for(row_data, :grade)
        grade && !grade.empty?
      end

      def extract_record(row_data, term)
        record_data = {
            course: extract_record_data_for(row_data, :number),
            name: extract_record_data_for(row_data, :name),
            section: extract_record_data_for(row_data, :section),
            credits: extract_record_data_for(row_data, :credits),
            grade: extract_record_data_for(row_data, :grade),
            average: extract_record_data_for(row_data, :average),
        }

        output = {}
        output[:course] = Course::Course.find_by_string(record_data[:course], @university)
        output[:grade] = @university.grading_system.entities.find_by_name(record_data[:grade])
        output[:term] = term
        output
      end

    end
  end
end