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
    allow(STDOUT).to receive(:puts)

    allow(csv_double).to receive(:foreach)
      .and_yield([first_name, surname, birthplace, cohort])
      .and_yield([first_name, surname, birthplace, cohort])
  end

  describe 'when the application starts up' do
    context 'given no filepath has been provided in the args' do
      it 'should instruct CSV loader to load default file' do
        allow(ARGV).to receive(:first).and_return(nil)
        expected_filepath = Storage::DEFAULT_STUDENTS_FILEPATH

        storage.initial_load_students

        expect(csv_double).to have_received(:foreach).with(expected_filepath)
      end
    end

    context 'given valid filepath is provided in args' do
      it 'should instruct CSV loader to load that filepath' do
        filepath_from_args = './somefile.csv'
        allow(ARGV).to receive(:first).and_return(filepath_from_args)
        allow(File).to receive(:exist?).and_return(true)

        storage.initial_load_students

        expect(csv_double).to have_received(:foreach).with(filepath_from_args)
      end
    end

    describe 'when CSV loader loads students file' do
      it 'should return array of students from file' do
        allow(ARGV).to receive(:first).and_return(nil)
        expected_list_students = [student_double, student_double]

        expect(storage.initial_load_students).to eq(expected_list_students)
      end
    end
  end

  describe 'when user enters a filepath to load students' do
    before(:each) do
      allow(STDIN).to receive(:gets).and_return('somefile.csv')
    end

    it 'should load CSV file and return as list of students' do
      expected_list_students = [student_double, student_double]

      expect(storage.load_students).to eq(expected_list_students)
    end

    it 'should pass the entered filepath to the CSV loader' do
      storage.load_students

      expect(csv_double).to have_received(:foreach).with('somefile.csv')
    end
  end

  describe 'when user does NOT enter a filepath to load students' do
    it 'should pass default filepath to CSV loader' do
      allow(STDIN).to receive(:gets).and_return("\r\n")

      storage.load_students

      expect(csv_double).to have_received(:foreach).with('students.csv')
    end
  end
end
