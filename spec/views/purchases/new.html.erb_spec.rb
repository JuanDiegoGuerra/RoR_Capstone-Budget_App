require 'rails_helper'

RSpec.describe 'Purchases', type: :system do
  describe 'New page' do
    let!(:user) do
      User.create(name: 'Juan', email: 'juan@gmail.com', password: 'password', password_confirmation: 'password')
    end

    let!(:group) do
      Group.create(name: 'Subway',
                   icon: 'https://i.pinimg.com/originals/4b/eb/2a/4beb2a37a5810f9eacc37e3c6234889c.png',
                   author_id: user.id)
    end

    before do
      sign_in user
      visit new_group_purchase_path(group.id)
    end

    it 'displays the page title' do
      expect(page).to have_content('NEW TRANSACTION')
    end

    it 'displays the navigation bar' do
      expect(page).to have_content('ADD TRANSACTION')
      expect(page).to have_link('Search')
    end

    it 'displays the transaction name input field' do
      expect(page).to have_field('TRANSACTION NAME')
    end

    it 'displays the amount input field' do
      expect(page).to have_field('AMOUNT')
    end

    it 'displays the group checkboxes' do
      expect(page).to have_content('Subway')
      expect(page).to have_selector('input[type="checkbox"]')
    end

    it 'displays the save transaction button' do
      expect(page).to have_button('SAVE TRANSACTION')
    end

    it 'creates a new purchase with valid input' do
      fill_in 'TRANSACTION NAME', with: 'Sandwich'
      fill_in 'AMOUNT', with: '1.5'
      check('purchase[group_ids][]', option: group.id)
      click_button 'SAVE TRANSACTION'

      expect(page).to have_content('Transaction was successfully created.')
    end

    it 'displays an error message with invalid input' do
      fill_in 'TRANSACTION NAME', with: ''
      fill_in 'AMOUNT', with: '1.5'
      click_button 'SAVE TRANSACTION'

      expect(page).to have_content('You should select at least one group.')
    end
  end
end