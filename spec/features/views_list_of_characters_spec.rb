require 'rails_helper'

feature 'user views list of characters', %Q{
  As a site visitor
  I want to view a list of people's favorite TV characters
  So I can find wonky characters to watch
} do

  # Acceptance Criteria:
  # * I can see a list of all the characters
  # * The character's name and the TV show it is associated with are listed

  scenario 'user views all characters' do

    show = TelevisionShow.create(title: 'Game of Thrones',
    network: 'HBO' )

    characters = []
    char_attrs = [
      { character_name: 'Legolas', actor_name: 'HBO', television_show_id: show.id },
      { character_name: 'Orphan Black', actor_name: 'BBC America', television_show_id: show.id }
    ]

    char_attrs.each do |attrs|
      characters << Character.create(attrs)
    end

    visit '/characters'

    characters.each do |char|
      expect(page).to have_content char.character_name
      expect(page).to have_content char.television_show.title
    end
  end
end
