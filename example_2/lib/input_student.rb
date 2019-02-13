class InputStudent
  def initialize(student)
    @student = student
  end

  def user_input
    puts "Please enter the first name, last name, birthplace and cohort of each student.\n"

    puts "Enter first name:"
    first_name = STDIN.gets.gsub("\n", "")

    puts "Enter surname:"
    surname = STDIN.gets.gsub("\n", "")

    puts "Enter birthplace:"
    birthplace = STDIN.gets.gsub("\n", "")

    puts "Enter cohort:"
    cohort = STDIN.gets.gsub("\n", "")

    @student.new(first_name: first_name, surname: surname, birthplace: birthplace, cohort: cohort)
  end
end