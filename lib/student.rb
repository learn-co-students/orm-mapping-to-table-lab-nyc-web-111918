class Student

  attr_reader :id
  attr_accessor :name, :grade

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    DB[:conn].execute("
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER);
      ")
  end

  def self.drop_table
    DB[:conn].execute("
      DROP TABLE students;
      ")
  end

  def save
    DB[:conn].execute("
      INSERT INTO students (name, grade) VALUES (?, ?)", self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(attributes)
    new_student = Student.new(nil, nil)
    attributes.each {|key, value| new_student.send("#{key}=", value)}
    new_student.save
    new_student
  end


end
