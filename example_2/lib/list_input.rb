class ListInput
  def initialize(field_input)
    @field_input = field_input
  end

  def input(field)
    list = []

    while true do
      puts "Hit 'done' to exit or 'add' to enter (a)nother student.\n"
      selection = STDIN.gets.delete("\n")

      if selection == 'done'
        break
      elsif selection == 'add'
        list << @field_input.input
      end
    end

    return list
  end
end
