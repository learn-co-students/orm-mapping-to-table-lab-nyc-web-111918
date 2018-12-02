require 'pry'
class Student

  attr_reader :name, :id
  attr_accessor :grade

  @@class_counter = 0

  def initialize(id = nil, name , grade)
    @grade = grade
    @name = name
    @id = id

  end


  def self.create_table
    sql = <<-SQL
      CREATE TABLE students
      (id INTEGER PRIMARY KEY, name TEXT, grade INTEGER);
      SQL



    DB[:conn].execute(sql)
  end

  def self.drop_table

    DB[:conn].execute("DROP TABLE students;")
  end

  def save



    sql = <<-SQL
          INSERT INTO students (name, grade)
          VALUES (?, ?)
        SQL
        #binding.pry

        DB[:conn].execute(sql, self.name, self.grade)

        @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

  end

  def self.create (name: name, grade: grade)

    new_student = Student.new(name, grade)
    new_student.save
    new_student

#sql = <<-SQL
#  INSERT INTO students
#  SQL

  end
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
