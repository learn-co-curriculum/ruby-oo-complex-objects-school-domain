# code here!

class School

    attr_accessor :name, :roster

    def initialize(school_name)
        @school_name =school_name
        @roster = {}
    end

    def add_student(name, grade)
        @roster[grade] ||= []
        @roster[grade] << name
    end

    def grade(grade_number)
        @roster[grade_number]
    end

    def sort
        @roster.each do |grade, students|
            students.sort!
        end
    end

end





# def add_student(name, grade)
#     if !@roster[grade]
#         @roster[grade] = []
#         @roster[grade] << name
#     else
#     @roster[grade] << name
#     end
# end



# class School

#     attr_reader :roster

#     def initialize(school_name)
#         @school = school_name
#         @roster = {}
#     end

#     def add_student(name, grade)
#         roster[grade] ||= []
#         roster[grade] << name
#     end

#     def grade(grade)
#         roster[grade]
#     end

#     def sort
#         sorted = {}
#         roster.each do |grade, names|
#             sorted[grade] = names.sort
#         end
#         sorted
#     end

# end