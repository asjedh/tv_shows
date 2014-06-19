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

  scenario 'user can delete a character ' do
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

    character_to_delete = Character.create(character_attrs)

     other_character_attrs = {
      character_name: 'WHEFIFE',
      actor_name: 'Shorty',
      description: "He's my hero!",
      television_show_id: show.id
    }

    other_character = Character.create(other_character_attrs)
    #navigate to add character page for that movie
    #fill in and submit add character form
    page.driver.submit :delete, "/characters/#{character_to_delete.id}", {}
    #expect page to have certain attributes

    expect(page).to have_content "#{character_to_delete.character_name} has been deleted!"
    expect(page).to have_content other_character.character_name
    expect(page).to have_content other_character.television_show.title

    expect(page).to_not have_content character_to_delete.actor_name

  end
end
