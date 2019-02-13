require './lib/input_student.rb'

describe InputStudent do
  before(:each) do
    @student_double = double(:student)
    @student_class_double = double(:Student, new: @student_double)
    @student_input = InputStudent.new(@student_class_double)
  end

  it 'should get a new student from the user and create new student instance' do
    first_name = 'Simon'
    surname = 'Norman'
    birthplace = 'Maidstone'
    cohort = 'December'

    allow(STDIN).to receive(:gets).and_return(first_name, surname, birthplace, cohort)
    @student_input.user_input
    
    expect(@student_class_double).to have_received(:new).with({
      first_name: first_name, 
      surname: surname, 
      cohort: cohort, 
      birthplace: birthplace
    })
  end

  it 'should return the new student' do
    allow(STDIN).to receive(:gets).and_return("")

    expect(@student_input.user_input).to eq(@student_double)
  end
end