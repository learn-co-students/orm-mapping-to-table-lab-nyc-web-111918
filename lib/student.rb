class Student
  attr_accessor :name, :grade
  attr_reader :id

  @@class_counter = 0

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
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
         DB[:conn].execute(sql, self.name, self.grade)
         @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

  end


  def self.create (name: name, grade: grade)
       new_student = Student.new(name, grade)
      new_student.save
      new_student
     end


  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

end
