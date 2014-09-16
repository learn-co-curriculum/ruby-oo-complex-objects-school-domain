class School
  attr_accessor :name, :roster

  def initialize(name)
    @name = name
    @roster = {}
  end

  def add_student(student_name, grade)
    roster[grade] ||= []
    roster[grade] << student_name
  end

  def grade(student_grade)
    roster[student_grade]
  end

  def sort
    sorted = Hash[roster.sort_by {|k,v| k }]
    sorted.keys.each do |k,v|
      sorted[k].sort!
    end
    sorted
  end
end
