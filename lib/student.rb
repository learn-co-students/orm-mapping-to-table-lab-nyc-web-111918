class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
  attr_accessor :name, :grade
  attr_reader :id
  ALL = []

  def initialize(name, grade, id = nil)
    @name, @grade, @id = name, grade, id
    ALL << self
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students(
      id INTEGER PRIMARY KEY, name TEXT, grade INTEGER)
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
      DROP TABLE students
    SQL
    DB[:conn].execute(sql)
  end

  def save
    sqlsetself = <<-SQL
      INSERT INTO students(name, grade) VALUES (?,?)
    SQL
    DB[:conn].execute(sqlsetself, self.name, self.grade)
    @id = DB[:conn].execute("SELECT id FROM STUDENTS WHERE name = '#{self.name}'").first.first
  end

  #there is probably a better way
  # def id
  #   DB[:conn].execute("SELECT id FROM STUDENTS WHERE name = '#{self.name}'").first.first
  # end

  def self.create(data = {})
    new_student = Student.new(data[:name], data[:grade])
    new_student.save
    new_student
  end
end
