require './lib/storage.rb'

describe Storage do
  let (:student_double) { double(:student) }
  let (:student_class_double) { double(:Student, new: student_double) }
  let (:csv_double) { double(:CSV) }
  let (:first_name) { 'Simon' }
  let (:surname) { 'Norman' }
  let (:birthplace) { 'Maidstone' }
  let (:cohort) { 'December' }

  it 'should load CSV file and return as list of students' do
    allow(csv_double).to receive(:foreach)
      .and_yield([first_name, surname, birthplace, cohort])
      .and_yield([first_name, surname, birthplace, cohort])

    storage = Storage.new(student_class: student_class_double, csv: csv_double)

    expected_list_students = [student_double, student_double]

    expect(storage.load_students_file('students.csv')).to eq(expected_list_students)
  end
end
