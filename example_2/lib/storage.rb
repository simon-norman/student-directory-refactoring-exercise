class Storage
  DEFAULT_STUDENTS_FILEPATH = 'students.csv'.freeze

  def initialize(student_class:, csv:)
    @student_class = student_class
    @csv = csv
  end

  def initial_load_students
    filename = ARGV.first
    if filename.nil?
      students = load_default_students_file
    elsif File.exist?(filename)
      students = load_students_file(filename)
    else
      exit_app_as_no_file
    end

    students
  end

  def load_default_students_file
    students = load_students_file(DEFAULT_STUDENTS_FILEPATH)
    puts 'No file was given on startup so loaded "students.csv" by default.'
    students
  end

  def load_students_file(filename)
    students = []
    @csv.foreach(filename) do |csv_row|
      students << new_student_from(csv_row)
    end

    puts "Loaded #{students.count} from #{filename}"
    students
  end

  def exit_app_as_no_file
    puts "Sorry, #{filename} doesn't exist."
    exit
  end

  def load_students
    puts "Please enter the filename (inc. extension) that you'd like to load:"
    filename = STDIN.gets.chomp
    filename = 'students.csv' if filename == ''

    load_students_file(filename)
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
