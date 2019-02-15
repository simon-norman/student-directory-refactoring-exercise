class StudentInput
  def initialize(student)
    @student = student
  end

  def input
    puts "Please enter the first name, last name, birthplace and cohort of each student.\n"

    first_name = input_field('first_name')
    surname = input_field('surname')
    birthplace = input_field('birthplace')
    cohort = input_field('cohort')

    @student.new(first_name: first_name, surname: surname, birthplace: birthplace, cohort: cohort)
  end

  def input_field(field_name)
    puts "Enter #{field_name}"
    STDIN.gets.gsub("\n", "")
  end
end