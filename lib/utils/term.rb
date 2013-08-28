class Term
  attr_accessor :semester, :year

  def initialize(semester = nil, year = nil)
    @semester = semester
    @year = year
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

end