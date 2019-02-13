require './lib/student.rb'

describe Student do
  let (:first_name) { 'Simon' }
  let (:surname) { 'Norman' }
  let (:birthplace) { 'Maidstone' }
  let (:cohort) { 'December' }
  let (:student_data) do
    {
      first_name: first_name,
      surname: surname,
      cohort: cohort,
      birthplace: birthplace
    }
  end

  it 'should create a student with default attributes if no params passed' do
    student = Student.new

    expect(student.first_name).to eq('--')
    expect(student.surname).to eq('--')
    expect(student.birthplace).to eq('--')
    expect(student.cohort).to eq(:unknown)
  end

  it 'should create a new student with a first name and cohort' do
    student = Student.new(student_data)

    expect(student.first_name).to eq(first_name)
    expect(student.surname).to eq(surname)
    expect(student.birthplace).to eq(birthplace)
    expect(student.cohort).to eq(:Dec)
  end

  it 'should try to identify cohort even if not fully provided or mispelled' do
    cohort = 'nOvEEEm39931djfkdjeihe'
    student_data_mispelled_cohort = student_data
    student_data_mispelled_cohort[:cohort] = cohort
    
    student = Student.new(student_data_mispelled_cohort)

    expect(student.cohort).to eq(:Nov)
  end
end
