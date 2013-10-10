require 'sqlite3'

class Student
  ATTRIBUTES = {
    :id => "INTEGER PRIMARY KEY AUTOINCREMENT",
    :name => "TEXT",
    :twitter => "TEXT",
    :facebook => "TEXT",
    :linkedin => "TEXT",
    :github => "TEXT",
    :email => "TEXT",
    :website => "TEXT",
    :blog => "TEXT",
    :picture => "TEXT"
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

  self.attributes.each do |attribute_name|
    define_singleton_method("find_by_#{attribute_name}") do |attr_value|
      sql = "SELECT * FROM students WHERE #{attribute_name} = ?"
      results = @@db.execute sql, attr_value
      self.students_from_rows(results)
    end
  end 

  def self.table_name
    "#{self.to_s.downcase}s"
  end

  def self.columns_for_create
    self.attributes_hash.collect{|k,v| "#{k} #{v}"}.join(",")
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS #{self.table_name} (#{self.columns_for_create});"  
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
    "#{(["?"]*self.attributes_for_db.size).join(",")}"
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

  def attributes_for_insert
    self.attributes[1..-1]
  end

  def insert
    @@db.execute(self.class.insert_sql, self.attributes_for_insert)
    get_id
    @saved = true
  end

  def self.sql_for_update
    self.attributes_for_db.collect{|attribute| "#{attribute} = ?"}.join(",")
  end

  def attributes_for_update
    [self.attributes_for_insert, self.id].flatten
  end

  def update
    cmd = "UPDATE #{self.class.table_name} SET #{self.class.sql_for_update} WHERE id = ?"
    @@db.execute(cmd, self.attributes_for_update)
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

  def self.find(id)
    Student.find_by_id(id).first
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