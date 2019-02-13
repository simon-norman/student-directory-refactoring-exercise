require './lib/student.rb'

describe Student do
  it 'should create a new student with a first name and cohort' do
    first_name = 'Simon'
    surname = 'Norman'
    birthplace = 'Maidstone'
    cohort = 'December'
    student = Student.new(
      first_name: first_name,
      surname: surname,
      cohort: cohort,
      birthplace: birthplace
    )

    expect(student.first_name).to eq(first_name)
    expect(student.surname).to eq(surname)
    expect(student.birthplace).to eq(birthplace)
    expect(student.cohort).to eq(cohort)
  end
end
