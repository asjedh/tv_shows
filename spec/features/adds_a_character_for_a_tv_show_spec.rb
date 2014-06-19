require 'rails_helper'

feature 'user adds a new character for a TV show', %Q{
  As a site visitor
  I want to add my favorite TV show characters
  So that other people can enjoy their crazy antics
} do

  # Acceptance Criteria:
  # * I can access a form to add a character on a TV show's page
  # * I must specify the character's name and the actor's name
  # * I can optionally provide a description
  # * If I do not provide the required information, I receive an error message
  # * If the character already exists in the database, I receive an error message

  scenario 'user correctly adds a new character to a TV show' do
    #first need to create a new movie
    show_attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }


    show = TelevisionShow.create(show_attrs)

    #then need to create character for that move
    character_attrs = {
      character_name: 'Tyrian Lancaster',
      actor_name: 'Shorty',
      description: "He's my hero!"
    }

    character = Character.new(character_attrs)
    #navigate to add character page for that movie
    #fill in and submit add character form
    visit "/television_shows/#{show.id}/characters/new"
      fill_in 'Character name', with: character.character_name
      fill_in 'Actor name', with: character.actor_name
      fill_in 'Description', with: character.description
    click_on 'Submit'

    #expect page to have certain attributes
    expect(page).to have_content 'Success'
    expect(page).to have_content character.character_name
    expect(page).to have_content character.actor_name
    expect(page).to have_content character.description

  end

  scenario 'user adds a new character to a TV show without required info' do
    #first need to create a new show
    show_attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.create(show_attrs)

    #then need to create character for that move
    #navigate to add character page for that movie
    #fill in and submit add character form
    visit "/television_shows/#{show.id}/characters/new"
    click_on 'Submit'

    #expect page to have certain attributes
    expect(page).to_not have_content 'Success'
    expect(page).to have_content "Add A Character for #{show.title}"
    expect(page).to have_content "Character name can't be blank"

  end

  scenario 'user adds a previously-added character to a TV show' do
    #first need to create a new movie
    show_attrs = {
      title: 'Game of Thrones',
      network: 'HBO',
      years: '2011-',
      synopsis: 'Seven noble families fight for control of the mythical land of Westeros.'
    }

    show = TelevisionShow.create(show_attrs)

    #then need to create character for that move
    character_attrs = {
      character_name: 'Tyrian Lancaster',
      actor_name: 'Shorty',
      description: "He's my hero!",
      television_show_id: show.id
    }

    character = Character.create(character_attrs)
    #navigate to add character page for that movie
    #fill in and submit add character form
    visit "/television_shows/#{show.id}/characters/new"
      fill_in 'Character name', with: character.character_name
      fill_in 'Actor name', with: character.actor_name
      fill_in 'Description', with: character.description
    click_on 'Submit'

    #expect page to have certain attributes
    expect(page).to_not have_content 'Success'
    expect(page).to have_content "Add A Character for #{show.title}"
    expect(page).to have_content "Character name has already been taken"

  end


end
