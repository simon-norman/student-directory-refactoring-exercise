require './lib/storage.rb'

describe Storage do
  let (:student_double) { double(:student) }
  let (:student_class_double) { double(:Student, new: student_double) }
  let (:csv_double) { double(:CSV) }
  let (:first_name) { 'Simon' }
  let (:surname) { 'Norman' }
  let (:birthplace) { 'Maidstone' }
  let (:cohort) { 'December' }
  let (:storage) { storage = Storage.new(student_class: student_class_double, csv: csv_double) }

  before(:each) do
    allow(csv_double).to receive(:foreach)
      .and_yield([first_name, surname, birthplace, cohort])
      .and_yield([first_name, surname, birthplace, cohort])
  end

  describe 'when user enters a filename to load students' do
    before(:each) do
      allow(STDIN).to receive(:gets).and_return('somefile.csv')
      allow(STDOUT).to receive(:puts)
    end

    it 'should load CSV file and return as list of students' do
      expected_list_students = [student_double, student_double]

      expect(storage.load_students).to eq(expected_list_students)
    end

    it 'should pass the entered filename to the CSV loader' do
      storage.load_students

      expect(csv_double).to have_received(:foreach).with('somefile.csv')
    end
  end

  describe 'when user does NOT enter a filename to load students' do
    it 'should pass default filename to CSV loader' do
      allow(STDIN).to receive(:gets).and_return("\r\n")
      allow(STDOUT).to receive(:puts)

      storage.load_students

      expect(csv_double).to have_received(:foreach).with('students.csv')
    end
  end
end
