@students = []
@name = :name
@cohort = :cohort

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to file"
  puts "4. Load the list from previously saved file"
  puts "9. Exit"
end

def add_to_students_array(name, cohort)
  @students << {@name => name, @cohort => cohort.to_sym}
end

def student_s
  return "student" if @students.count == 1
  "students"
end

require 'csv'

def open_file(file_name)
  CSV.open(file_name, "r") do |newfile|
    newfile.readlines.each do |line|
      add_to_students_array(name=line[0], cohort=line[1])
    end
  end
end

def load_students
  puts "Please type file name:"
  file_name = gets.chomp
  open_file(file_name)
  puts "List loaded successfuly."
end

def load_students_at_launch
  filename = ARGV.first
  return if filename.nil?
  if File.exist?(filename)
    open_file(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def show_students
  return puts "There are no students saved to the list yet." if @students.count == 0
  print_students_list
  print_students_footer
end

def process(selection)
  return input_students if selection == "1"
  return show_students if selection == "2"
  return save_students if selection == "3"
  return load_students if selection == "4"
  return exit if selection == "9"
  puts "I don't know what you meant. Try again."
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def save_students
  puts "Please type file name:"
  file_name = gets.chomp
  CSV.open(file_name, "w") do |newfile|
    @students.each do |student|
      student_data = [student[@name], student[@cohort]]
      newfile.puts student_data
    end
  end
  return puts "List saved successfuly." if @students.count > 0
  puts "The list is empty - nothing to be saved."
end

def input_students(students = [])
  puts "Please enter the name of the student"
  puts "To finish, just hit return twice"
  tbc = "TBC"
  name = STDIN.gets.chomp
  name = tbc if name.empty?
  puts "Please enter the student's cohort"
  cohort = STDIN.gets.chomp
  cohort = tbc if cohort.empty?
  months = %w(january february march april may june july august september october november december tbc)
  while !months.include? cohort.downcase
    puts "You misspelled the cohort, please type it again"
    cohort = STDIN.gets.chomp
  end
  add_to_students_array(name, cohort) if name != tbc || cohort != tbc
  puts "Now we have #{@students.count} #{student_s}"
  input_students(@students) unless name == tbc && cohort == tbc
end

def print_students_header
  puts "The students of Villains Academy"
  puts "--------------"
end

def print_students_list
  if @students.count > 0
    print_students_header
    hash_co = @students.group_by { |entry| entry[@cohort] }
    hash_co.each do |key, value|
      puts "#{key.capitalize} cohort"
      for i in 0..value.length-1 do
        puts "#{i+1}. #{value[i][@name]}"
      end
    end
  end
end

def print_students_footer
    puts "Overall, we have #{@students.count} great #{student_s}" if @students.count > 0
end

load_students_at_launch
interactive_menu
