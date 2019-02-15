require 'csv'
require_relative './student_input/student_input.rb'
require_relative './student_input/list_input'
require_relative './student.rb'
require_relative './storage.rb'

$students = [] # an empty array accessible to all methods (global variable)

$student_input = StudentInput.new(Student)

$list_input = ListInput.new($student_input, 'student')

$storage = Storage.new(student_class: Student, csv: CSV)

# INTERACTIVE MENU --------------------------------------------------------------

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to a csv file"
    puts "4. Load the list from a csv file"
    puts "5. Print the source code for this programme"
    puts "9. Exit" # 9 because we'll be adding more items
end

def interactive_menu
    loop do
        print_menu
        process(STDIN.gets.chomp)
    end
end

def process(selection)
    case selection
    when "1"
        $students = $list_input.input
        feedback_message("data entered")
    when "2"
        if !$students.empty?
            show_students
            feedback_message("data printed")
        else
            puts "There are currently no students in the system to display."
        end
        # can also use an unless statement: print(students) unless students.empty?
    when "3"
        $storage.save_students($students)
        feedback_message("data saved")
    when "4"
        $students = $storage.load_students
        feedback_message("data loaded")
    when "5"
        source_code
        feedback_message("source code printed")
    when "9"
        exit # this will cause the program to terminate
    else
        puts "I don't know what you mean. Try again!"
    end
end

def feedback_message(operation)
    puts "\v#{operation.upcase} SUCCESSFULLY!\v"
end

# PRINTING SOURCE CODE-----------------------------------------------------------

def source_code
    File.open($0, "r") { |sc|
        puts
        sc.readlines.each do |line|
            puts line
        end
    }
end

# PRINTING THE DATA -------------------------------------------------------------

def show_students
    print_header
    print_students_list
    print_footer
end

def print_header
    puts "\nThe students of Villains Academy"
    puts "-------------"
end

def print_students_list
    $students.each_with_index do |student, index|
        puts "#{index + 1}. #{student.first_name} (#{student.cohort} cohort)"
    end
end

def print_footer
    puts "Overall, we have #{$students.count} great students.\n"
end

# CUSTOM PRINTING METHODS -------------------------------------------------------

def print_all(students)
    students.each do |student|
        puts "#{student.first_name} #{student.surname} | #{student.birthplace} | Cohort: #{student.cohort}"
    end
end

def print_beginwitha(students)
    puts "Register of students (with names beginning in \"A\"):"
    students.each do |student|
        if student.first_name[0] == "a" || student.first_name[0] == "A"
            puts "\t#{student.first_name} (#{student.cohort} cohort)"
        else
            next
        end
    end
end

def print_lessthan12(students)
    puts "Register of students (with names less than 12 characters):"
    students.each do |student|
        if student.first_name.length < 12
            puts "\t#{student.first_name} (#{student.cohort} cohort)"
        else
            next
        end
    end
end

def print_usingwhile(students)
    count = 0
    while count < students.length
        puts "#{students[count].first_name} (#{students[count].cohort} cohort)"
        count += 1
    end
end

def print_centered(students)
    puts "Here is our nicely formatted graduation attendee poster:".center(70).upcase
    students.each do |student|
        puts "#{student.first_name}".center(70, "-")
        puts "(#{student.cohort} cohort)".center(70)
    end
end

def existing_cohorts(students)
    cohorts = []
    students.each do |x|
        if cohorts.empty?
            cohorts << x.cohort
        elsif cohorts.include? x.cohort
            next
        else
            cohorts << x.cohort
        end
    end
    return cohorts
end

def print_bycohort(students)
    cohort_list = existing_cohorts(students)
    cohort_list.each do |month|
        puts "\nHere are the students from the #{month} cohort:"
        students.each do |x|
            if x.cohort == month
                puts "#{x.first_name} #{x.surname}"
            else
                next
            end
        end
    end
end

$students = $storage.initial_load_students
interactive_menu

# EXAMPLE CALLS FOR CUSTOM PRINTING METHODS -------------------------------------

# nothing happens until we call the methods
# uncomment out the methods to test
# commented here to make output more readable for current exercise

# students = data_entry_loop
# print_header
# print_students_list(students)
# print_footer(students)

# print_beginwitha(students)
# print_lessthan12(students)
# print_usingwhile(students)
# print_centered(students)
# print_all(students)
# print_bycohort(students)