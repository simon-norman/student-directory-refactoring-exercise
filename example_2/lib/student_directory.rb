require 'csv'

$students = [] # an empty array accessible to all methods (global variable)

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
        data_entry_loop
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
        save_students
        feedback_message("data saved")
    when "4"
        load_students
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

# WORKING WITH CSV --------------------------------------------------------------

def save_students
    # ask user for file
    puts "Please enter the filename (inc. extension) in which you'd like to save the data:"
    filename = STDIN.gets.chomp

    # open the file for writing
    CSV.open(filename, "wb") { |csv|
        $students.each do |student|
            student_data = [student[:firstname], student[:surname], student[:birthplace], student[:cohort]]
            csv << student_data
        end
    }
end

def load_file(filename)
    CSV.foreach(filename) { |row|
        push_to_array(firstname: row[0], surname: row[1], birthplace: row[2], cohort: row[3].to_sym)
    }
end

def load_students(filename = "students.csv")
    # ask user for file
    puts "Please enter the filename (inc. extension) that you'd like to load:"
    filename = STDIN.gets.chomp

    load_file(filename)
end

def initial_load_students
    filename = ARGV.first # first argument from the command line
    if filename.nil?
        load_file("students.csv")
        puts "No file was given on startup so loaded \"students.csv\" by default."
    elsif File.exists?(filename) # if it exists
        load_students(filename)
        puts "Loaded #{$students.count} from #{filename}"
    else # if it doesn't exist
        puts "Sorry, #{filename} doesn't exist."
        exit # quit the programe
    end
end

# USER DATA ENTRY ---------------------------------------------------------------

def prompt(output)
    if output.length < 1
        puts "Hit enter to exit or \"-\" to enter (a)nother student.\n"
        enter = STDIN.gets.gsub("\n", "")

        if !enter.empty? # if user has not hit enter, repeat user data entry prompt sequence
            details = user_data_entry
        else
            details = Hash.new
        end
    else
        details = user_data_entry
    end

    return details
end

def spellcheck(input_month)
    test = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"]

    test.each do |x|
        if input_month[0..2].downcase == x[0..2].downcase then input_month = x.downcase.to_sym end
    end

    return input_month
end

def user_data_entry
    details = {
        firstname: "--",
        surname: "--",
        birthplace: "--",
        cohort: :unknown
    }

    puts "Please enter the first name, last name, birthplace and cohort of each student.\n"

    puts "Enter first name:"
    name = STDIN.gets.gsub("\n", "")
    if !name.empty? then details[:firstname] = name end

    puts "Enter surname:"
    family = STDIN.gets.gsub("\n", "")
    if !family.empty? then details[:surname] = family end

    puts "Enter birthplace:"
    place = STDIN.gets.gsub("\n", "")
    if !place.empty? then details[:birthplace] = place end

    puts "Enter cohort:"
    month = STDIN.gets.gsub("\n", "")
    if !month.empty? then details[:cohort] = spellcheck(month) end

    return details
end

def push_to_array(args = {})
    defaults = {
        firstname: "--",
        surname: "--",
        birthplace: "--",
        cohort: :unknown
    }
    args = defaults.merge(args)
    $students << args
end

def data_entry_loop
    # create an empty array
    details = prompt($students)

    # add student hash to the array
    if !details.empty?
        push_to_array(details)
        puts $students.count == 1 ? "Now we have #{$students.count} student." : "Now we have #{$students.count} students."
        puts "Hit enter to exit or \"-\" to enter (a)nother student.\n"
        enter = STDIN.gets.gsub("\n", "")

        while !enter.empty?
            # continuing adding the student hashes to the array
            details = prompt($students)
            push_to_array(details)
            puts $students.count == 1 ? "Now we have #{$students.count} student." : "Now we have #{$students.count} students."
            puts "Hit enter to exit or \"-\" to enter (a)nother student.\n"
            enter = STDIN.gets.gsub("\n", "")
        end
    end

    # return the array of students
    $students
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
        puts "#{index + 1}. #{student[:firstname]} (#{student[:cohort]} cohort)"
    end
end

def print_footer
    puts "Overall, we have #{$students.count} great students.\n"
end

# CUSTOM PRINTING METHODS -------------------------------------------------------

def print_all(students)
    students.each do |student|
        puts "#{student[:firstname]} #{student[:surname]} | #{student[:birthplace]} | Cohort: #{student[:cohort]}"
    end
end

def print_beginwitha(students)
    puts "Register of students (with names beginning in \"A\"):"
    students.each do |student|
        if student[:firstname][0] == "a" || student[:firstname][0] == "A"
            puts "\t#{student[:firstname]} (#{student[:cohort]} cohort)"
        else
            next
        end
    end
end

def print_lessthan12(students)
    puts "Register of students (with names less than 12 characters):"
    students.each do |student|
        if student[:firstname].length < 12
            puts "\t#{student[:firstname]} (#{student[:cohort]} cohort)"
        else
            next
        end
    end
end

def print_usingwhile(students)
    count = 0
    while count < students.length
        puts "#{students[count][:firstname]} (#{students[count][:cohort]} cohort)"
        count += 1
    end
end

def print_centered(students)
    puts "Here is our nicely formatted graduation attendee poster:".center(70).upcase
    students.each do |student|
        puts "#{student[:firstname]}".center(70, "-")
        puts "(#{student[:cohort]} cohort)".center(70)
    end
end

def existing_cohorts(students)
    cohorts = []
    students.each do |x|
        if cohorts.empty?
            cohorts << x[:cohort]
        elsif cohorts.include? x[:cohort]
            next
        else
            cohorts << x[:cohort]
        end
    end
    return cohorts
end

def print_bycohort(students)
    cohort_list = existing_cohorts(students)
    cohort_list.each do |month|
        puts "\nHere are the students from the #{month} cohort:"
        students.each do |x|
            if x[:cohort] == month
                puts "#{x[:firstname]} #{x[:surname]}"
            else
                next
            end
        end
    end
end

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
