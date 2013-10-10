Dir[File.join(File.dirname(__FILE__), "../lib", "*.rb")].each {|f| require f}

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

end



class DBBuddy
  #from logan
  def self.create
    db = SQLite3::Database.new('students.db')
    create = "CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)"
    db.execute(create)
    db
  end

  def self.destroy(db)
    db.execute("DELETE FROM students")
    db.execute("DELETE FROM sqlite_sequence WHERE name = 'students'")
    db.close
    db
  end

end

