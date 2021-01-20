# code here!

class School

    attr_reader :roster

    def initialize(school_name)
        @school = school_name
        @roster = {}
    end

    def add_student(name, grade)
        roster[grade] ||= []
        roster[grade] << name
    end

    def grade(grade)
        roster[grade]
    end

    def sort
        sorted = {}
        roster.each do |grade, names|
            sorted[grade] = names.sort
        end
        sorted
    end

end