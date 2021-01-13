# code here!
require 'pry'

class School
    def initialize(name)
        @name = name
        @roster = {}
    end

    def roster
        @roster
    end

    def add_student(student_name, grade)
        if @roster[grade]
            @roster[grade] << student_name
        else
            @roster[grade]=[]
            @roster[grade] << student_name
        end
    end

    def grade(grade)
        return @roster[grade]
    end

    def sort
        sorted_roster={}
        @roster.each do |grade, students|
            #binding.pry
            sorted_students=students.sort
            sorted_roster[grade] = sorted_students
        end
        sorted_roster
    end

end

# binding.pry
