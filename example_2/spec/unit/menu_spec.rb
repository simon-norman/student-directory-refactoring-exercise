require './lib/menu.rb'

describe Menu do
  it 'should print out menu options' do
    allow(STDOUT).to receive(:puts)

    menu = Menu.new
    menu.display

    expect(STDOUT).to have_received(:puts).once.with(Menu::MENU_OPTIONS)
  end
end
