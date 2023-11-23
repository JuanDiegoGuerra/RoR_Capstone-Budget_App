require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  describe 'New page' do
    let!(:user) do
      User.create(name: 'Juan', email: 'juan@gmail.com', password: 'password', password_confirmation: 'password')
    end

    before do
      sign_in user
      visit new_group_path
    end

    it 'displays the page title' do
      expect(page).to have_content('NEW CATEGORY')
    end

    it 'displays the navigation bar' do
      expect(page).to have_content('ADD CATEGORY')
      expect(page).to have_link('Search')
    end

    it 'displays the category name input field' do
      expect(page).to have_field('CATEGORY NAME')
    end

    it 'displays the icon URL input field' do
      expect(page).to have_field('ICON URL')
    end

    it 'displays the save category button' do
      expect(page).to have_button('SAVE CATEGORY')
    end

    it 'creates a new group with valid input' do
      fill_in 'CATEGORY NAME', with: 'Subway'
      fill_in 'ICON URL', with: 'https://example.com/icon.png'
      click_button 'SAVE CATEGORY'

      expect(page).to have_content('Category was successfully created.')
    end

    it 'displays an error message with invalid input' do
      fill_in 'CATEGORY NAME', with: ''
      fill_in 'ICON URL', with: 'https://example.com/icon.png'
      click_button 'SAVE CATEGORY'

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_field('CATEGORY NAME', with: '')
      expect(page).to have_field('ICON URL', with: 'https://example.com/icon.png')
    end
  end
end