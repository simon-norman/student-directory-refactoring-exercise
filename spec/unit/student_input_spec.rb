require './lib/student_input/student_input.rb'

describe StudentInput do
  let (:first_name) { 'Simon' }
  let (:surname) { 'Norman' }
  let (:birthplace) { 'Maidstone' }
  let (:cohort) { 'December' }

  let (:new_student_args) { {
    first_name: first_name, 
    surname: surname, 
    cohort: cohort, 
    birthplace: birthplace
  } }

  before(:each) do
    @student_double = double(:student)
    @student_class_double = double(:Student, new: @student_double)
    @student_input = StudentInput.new(@student_class_double)

    allow(STDIN).to receive(:gets).and_return(first_name, surname, birthplace, cohort)
    allow(STDOUT).to receive(:puts)
  end

  it 'should get a new student from the user and create new student instance' do
    @student_input.input
    
    expect(@student_class_double).to have_received(:new).with(new_student_args)
  end

  it 'should return the new student' do
    expect(@student_input.input).to eq(@student_double)
  end
end