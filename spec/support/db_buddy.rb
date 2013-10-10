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
