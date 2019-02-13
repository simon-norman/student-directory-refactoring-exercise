require './lib/student_directory.rb'

describe 'input students' do
  it 'should get a new student from the user' do
    firstname = 'Simon'
    surname = 'Norman'
    birthplace = 'Maidstone'
    cohort = 'December'
    expected_students = [{
      firstname: 'Simon',
      surname: 'Norman',
      birthplace: 'Maidstone',
      cohort: 'December'
    }]

    allow(STDIN).to receive(:gets).and_return("1", "-", firstname, surname, birthplace, cohort, "", "9")

    interactive_menu
    expect($students).to eq(expected_students)
  end
end