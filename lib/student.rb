require 'sqlite3'
require 'pry'

class Student
  ATTRIBUTES = {
    :name => "TEXT",
    :twitter => "TEXT",
    :facebook => "TEXT",
    :linkedin => "TEXT",
    :github => "TEXT",
    :email => "TEXT",
    :website => "TEXT",
    :id => "INTEGER PRIMARY KEY AUTOINCREMENT"
  }

  
  def self.attributes_hash
    ATTRIBUTES
  end

  def self.attributes
    ATTRIBUTES.keys
  end

  def self.attributes_for_db
    ATTRIBUTES.keys.reject{|k| k == :id}
  end

  attr_accessor *attributes_for_db

  attr_reader :id
 
  @@db = SQLite3::Database.new('students.db')


  def self.table_name
    "#{self.to_s.downcase}s"
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS #{self.table_name} (
        id INTEGER PRIMARY KEY,
        name TEXT,
        twitter TEXT,
        linkedin TEXT,
        facebook TEXT,
        website TEXT
      );
      SQL
    
    @@db.execute(sql);
  end
  create_table

  def new_record?
    !saved?
  end

  def saved?
    @saved
  end

  def self.count
    sql = "SELECT COUNT(*) FROM #{self.table_name};"
    result = @@db.execute(sql).flatten.first
  end

  def initialize(id = nil)
    @id = id
    if id.nil?
      @id = self.class.count + 1
    end
    @saved = !id.nil?
  end
 
  def get_id
    cmd = "SELECT MAX(id) FROM #{self.class.table_name}"
    @id = @@db.execute(cmd).flatten[0]
  end
  
  def self.column_names
    self.attributes_for_db.join(",")
  end 

  def self.question_marks_for_insert
    "(#{(["?"]*self.attributes_for_db.size).join(",")})"
  end

  def self.insert_sql
    "INSERT INTO #{self.table_name} (#{self.column_names}) VALUES (#{self.question_marks_for_insert})"
  end
 
  def attributes
    self.class.attributes.collect do |attribute|
      self.send(attribute)
      # self.send("name")
      # self.name
    end
  end

  def insert
    @@db.execute(self.class.insert_sql, self.attributes)
    get_id
    @saved = true
  end
 
  def update
    cmd = "UPDATE #{self.class.table_name} set name = ? where id = ?"
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
 
  def self.drop_table
    sql = "DROP TABLE #{self.table_name};"
    @@db.execute sql
  end

  def self.reset_all
    self.drop_table
    self.create_table
  end
 
  def self.all
    sql = "SELECT * FROM students;"
    results = @@db.execute sql
    self.students_from_rows(results)
  end
 
  def ==(other_student)
    self.id == other_student.id
  end

  def self.students_from_rows(results)
    results.collect do |row|
      Student.new_with_row(row)
    end
  end

  def self.find_by_name(name)
    sql = "SELECT * FROM students WHERE name = ?"
    results = @@db.execute sql, name
    self.students_from_rows(results)
  end
 
  def self.find(id)
    Student.load(id)
  end
 
  def self.delete(id)
    sql = "DELETE FROM #{self.table_name} WHERE id = ?"
    @@db.execute sql, id
  end
 
  def self.load(id)
    cmd = "SELECT * FROM #{self.table_name} WHERE ID = ?"
    result = @@db.execute(cmd, id)
    Student.new_with_row(result.flatten)
  end
 
  def self.new_with_row(row)
    # s = Student.new(row[0])
    # self.attributes_for_db.each_with_index do |attribute, i|
    #   s.send("#{attribute}=", row[i+1])
    # end  
    # s

    Student.new(row[0]).tap do |s|
      self.attributes_for_db.each_with_index do |attribute, i|
        s.send("#{attribute}=", row[i+1])
        # s.send("name=", "Avi")
        # s.name = "Avi"
      end  
    end

  end
end

binding.pry