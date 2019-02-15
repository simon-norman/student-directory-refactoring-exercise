class ListInput
  def initialize(record_input, record_name)
    @record_input = record_input
    @record_name = record_name
    @list = []
  end

  def input
    loop do
      puts "Hit 'done' to exit or 'add' to enter (a)nother #{@record_name}.\n"
      selection = STDIN.gets.delete("\n")

      break if selection == 'done'

      if selection == 'add'
        @list << @record_input.input
        print_current_record_count
      end
    end

    @list
  end

  def print_current_record_count
    sing_or_plural_end_char = @list.count == 1 ? '' : 's'

    puts "Now we have #{@list.count} #{@record_name}#{sing_or_plural_end_char}."
  end
end
