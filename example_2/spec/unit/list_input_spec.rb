require './lib/list_input.rb'

describe ListInput do
  it 'should, each time the user requests to input a record, request the record input to get that input' do
    allow(STDIN).to receive(:gets).and_return('add', 'add', 'done')
    
    field_input_double = double(:field_input, input: '')
    input_list = ListInput.new(field_input_double)

    input_list.input('student')

    expect(field_input_double).to have_received(:input).twice
  end
end
