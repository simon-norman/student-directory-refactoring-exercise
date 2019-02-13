class Menu
  MENU_OPTIONS =
    '1. Input the students'\
    '2. Show the students'\
    '3. Save the list to a csv file'\
    '4. Load the list from a csv file'\
    '5. Print the source code for this programme'\
    '9. Exit'.freeze

  def display
    puts MENU_OPTIONS
  end
end
