class Storage
  def initialize(student_class:, csv:)
    @student_class = student_class
    @csv = csv
  end

  def load_students(filename)
    students = []
    @csv.foreach(filename) do |csv_row|
      students << new_student_from(csv_row)
    end
    students
  end

  def new_student_from(csv_row)
    @student_class.new(
      first_name: csv_row[0],
      surname: csv_row[1],
      birthplace: csv_row[2],
      cohort: csv_row[3].to_sym
    )
  end
end