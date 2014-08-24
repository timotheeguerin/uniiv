module Utils
  class Term
    attr_accessor :semester, :year

    def initialize(semester = nil, year = nil)
      @semester = semester
      @year = year.to_i
    end

    def self.from_a(array)
      Term.new(Course::Semester.find_by_name(array[0]), array[1])
    end

    def self.from_string(str)
      Term.from_a(str.split(/[[:space:]]/))
    end

    #Return the falll semester of the current year
    def first_of_year
      case @semester.name
        when 'fall'
          self
        else
          Term.new(Course::Semester.find_by_name('fall'), @year -1)
      end
    end

    def next
      case @semester.name
        when 'winter'
          Term.new(Course::Semester.find_by_name('summer'), @year)
        when 'summer'
          Term.new(Course::Semester.find_by_name('fall'), @year)
        else
          Term.new(Course::Semester.find_by_name('winter'), @year + 1)
      end
    end


    def prev
      case @semester.name
        when 'winter'
          Term.new(Course::Semester.find_by_name('fall'), @year -1)
        when 'summer'
          Term.new(Course::Semester.find_by_name('winter'), @year)
        else
          Term.new(Course::Semester.find_by_name('summer'), @year)
      end
    end

    def self.now
      time = Time.now
      current_term = Term.new
      if time.month <= 4
        current_term.semester = Course::Semester.find_by_name('winter')
      elsif time.month <= 8
        current_term.semester = Course::Semester.find_by_name('summer')
      else
        current_term.semester = Course::Semester.find_by_name('fall')
      end
      current_term.year = time.year
      current_term
    end

    def self.last_allowed
      term = now
      term.year += 6
      term
    end

    def ==(comparison_object)
      comparison_object.instance_of?(self.class) and comparison_object.year == self.year and comparison_object.semester == self.semester
    end

    def to_s
      "#{semester.to_s.capitalize} #{year}"
    end

    def to_param
      {semester_id: semester.id, year: year}.to_param
    end
  end

end