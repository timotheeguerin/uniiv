class Term
  attr_accessor :semester, :year

  def initialize(semester = nil, year = nil)
    @semester = semester
    @year = year
  end

  def next
    case @semester.name
      when 'winter'
        Term.new(Course::Semester.find_by_name(:summer), @year)
      when 'summer'
        Term.new(Course::Semester.find_by_name(:fall), @year)
      else
        Term.new(Course::Semester.find_by_name(:winter), @year + 1)
    end
  end
end