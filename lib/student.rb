class Student
  attr_accessor :name, :twitter, :linkedin, :facebook, :website
  attr_reader :id

  @@students = []

  def initialize
    if @@students.count == 0
      @id = 1
    else
      @id = @@students.max_by { |s| s.id }.id + 1
    end
    @@students << self
  end

  def self.reset_all
    @@students.clear
  end

  def self.all
    @@students
  end

  def self.find_by_name(name)
    @@students.select { |s| s.name == name }
  end

  def self.find(id)
    @@students.select { |s| s.id == id }.first
  end

  def self.delete(id)
    @@students.reject! { |s| s.id == id}
  end

end
