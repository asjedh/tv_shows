require 'rails_helper'

feature "user views a TV show's details", %Q{
  As a site visitor
  I want to view the details for a TV show
  So I can find learn more about it
  I can see a the show's title, network, the years it ran, and a synopsis.
} do

  # Acceptance Criteria:
  # * I can see a the show's title, network, the years it ran,
  # and a synopsis.

  scenario "user views a TV show's details" do

    #create movie
    show = TelevisionShow.create(title: 'Game of Thrones',
      network: 'HBO' )

    #create characters for movie
    characters = []
    char_attrs = [
      { character_name: 'Legolas', actor_name: 'HBO', television_show_id: show.id },
      { character_name: 'Orphan Black', actor_name: 'BBC America', description: "Cool dude", television_show_id: show.id }
    ]

    char_attrs.each do |attrs|
      characters << Character.create(attrs)
    end


    visit "/television_shows/#{show.id}"

    expect(page).to have_content show.title
    expect(page).to have_content show.network
    expect(page).to have_content show.years
    expect(page).to have_content show.synopsis

    characters.each do |char|
      expect(page).to have_content char.character_name
      expect(page).to have_content char.actor_name
      expect(page).to have_content char.description
    end

  end
end
