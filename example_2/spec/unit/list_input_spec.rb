require './lib/list_input.rb'

describe ListInput do
  let (:record_input) { 'an inputted record' }
  let (:record_input_double) { double(:record_input, input: record_input) }
  let (:input_list) { ListInput.new(record_input_double, record_name) }
  let (:record_name) { 'student' }

  before(:each) do
    allow(STDIN).to receive(:gets).and_return('add', 'add', 'done')
    allow(STDOUT).to receive(:puts)
  end

  describe 'When the user requests to enter a input a list of records, ' do
    it 'should call record input method for each record input' do
      input_list.input

      expect(record_input_double).to have_received(:input).twice
    end

    it 'should ask user at the start, and after each record input, if they want to enter another' do
      input_list.input

      expected_request_to_user = "Hit 'done' to exit or 'add'"\
        " to enter (a)nother #{record_name}.\n"

      expect(STDOUT).to have_received(:puts).exactly(3)
        .times.with(expected_request_to_user)
    end

    describe 'when, after each record, puts the current number of records entered' do
      it 'should format record name as plural when more than 1 record' do
        input_list.input
        expected_outputted_record_count = "Now we have 2 #{record_name}s."

        expect(STDOUT).to have_received(:puts).exactly(1)
          .times.with(expected_outputted_record_count)
      end

      it 'should format record name as singular when ONLY 1 record' do
        input_list.input
        expected_outputted_record_count = "Now we have 1 #{record_name}."

        expect(STDOUT).to have_received(:puts).exactly(1)
          .times.with(expected_outputted_record_count)
      end
    end

    it 'should return the list of records captured from user' do
      expected_list_records = [record_input, record_input]

      expect(input_list.input).to eq(expected_list_records)
    end
  end
end
