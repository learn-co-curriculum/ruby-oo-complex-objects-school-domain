# DEPRECATED

# require 'sqlite3'
# require 'pry'

# class Student
#   attr_accessor :name, :twitter, :linkedin, :facebook, :website
#   attr_reader :id
 
#   @@db = SQLite3::Database.new('students.db')
  
   
#   def self.table_name
#     "#{self.to_s.downcase}s"
#   end

#   def self.create_table
#     sql = <<-SQL
#       CREATE TABLE IF NOT EXISTS #{self.table_name} (
#         id INTEGER PRIMARY KEY,
#         name TEXT,
#         twitter TEXT,
#         linkedin TEXT,
#         facebook TEXT,
#         website TEXT
#       );
#       SQL
    
#     @@db.execute(sql);
#   end
#   create_table

#   def new_record?
#     !saved?
#   end

#   def saved?
#     @saved
#   end

#   def self.count
#     sql = "SELECT COUNT(*) FROM #{self.table_name};"
#     result = @@db.execute(sql).flatten.first
#   end

#   def initialize(id = nil)
#     @id = id
#     if id.nil?
#       @id = self.class.count + 1
#     end
#     @saved = !id.nil?
#   end
 
#   def get_id
#     cmd = "SELECT MAX(id) FROM #{self.class.table_name}"
#     @id = @@db.execute(cmd).flatten[0]
#   end
 
#   def insert
#     cmd = "INSERT INTO #{self.class.table_name} (name) VALUES (?)"
#     @@db.execute(cmd, self.name)
#     get_id
#     @saved = true
#   end
 
#   def update
#     cmd = "UPDATE #{self.class.table_name} set name = ? where id = ?"
#     @@db.execute(cmd, self.name, self.id)
#     @saved = true
#   end
 
#   def save
#     if @saved
#       update
#     else
#       insert
#     end
#   end
 
#   def self.drop_table
#     sql = "DROP TABLE #{self.table_name};"
#     @@db.execute sql
#   end

#   def self.reset_all
#     self.drop_table
#     self.create_table
#   end
 
#   def self.all
#     @@students
#   end
 
#   def self.find_by_name(name)
#     @@students.select { |s| s.name == name }
#   end
 
#   def self.find(id)
#     Student.load(id)
#   end
 
#   def self.delete(id)
#     @@students.reject! { |s| s.id == id}
#   end
 
#   def self.load(id)
#     cmd = "SELECT * FROM #{self.table_name} WHERE ID = ?"
#     result = @@db.execute(cmd, id)
#     Student.new_with_row(result.flatten)
#   end
 
#   def self.new_with_row(row)
#     s = Student.new(row[0])
#     s.name = row[1]
#     s
#   end
# end

# s = Student.new
# s.name = "Avi"
# binding.pry











