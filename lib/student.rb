require 'sqlite3'

class Student
  attr_accessor :name, :twitter, :linkedin, :facebook, :website
  attr_reader :id

  @@students = []

  @@db = SQLite3::Database.new('students.db')

  def initialize(id = nil)
    @id = id
    if id.nil?
      if @@students.count == 0
        @id = 1
      else
        @id = @@students.max_by { |s| s.id }.id + 1
      end
    end 
    @@students << self
    @saved = !id.nil?
  end

  def get_id
    cmd = "SELECT MAX(id) from STUDENTS"
    @id = @@db.execute(cmd).flatten[0]
  end

  def insert
    cmd = "INSERT INTO STUDENTS (name) VALUES (?)"
    @@db.execute(cmd, self.name)
    get_id
    @saved = true
  end

  def update
    cmd = "UPDATE STUDENTS set name = ? where id = ?"
    @@db.execute(cmd, self.name, self.id)
    @saved = true
  end

  def save
    if @saved
      update
    else
      insert
    end
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
    Student.load(id)
  end

  def self.delete(id)
    @@students.reject! { |s| s.id == id}
  end

  def self.load(id)
    cmd = "SELECT * FROM STUDENTS WHERE ID = ?"
    result = @@db.execute(cmd, id)
    Student.new_with_row(result.flatten)
  end

  def self.new_with_row(row)
    s = Student.new(row[0])
    s.name = row[1]
    s
  end
end
