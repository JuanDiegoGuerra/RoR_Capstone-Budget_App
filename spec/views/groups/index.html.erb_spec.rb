require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  describe 'Index page' do
    let!(:user) do
      User.create(name: 'Luis', email: 'luis@gmail.com', password: 'password', password_confirmation: 'password')
    end

    let!(:group) do
      Group.create(name: 'Subway',
                   icon: 'https://i.pinimg.com/originals/4b/eb/2a/4beb2a37a5810f9eacc37e3c6234889c.png',
                   author_id: user.id)
    end

    let!(:group2) do
      Group.create(name: 'Mac donalds',
                   icon: 'https://es.logodownload.org/wp-content/uploads/2018/11/McDonalds-logo-11.png',
                   author_id: user.id)
    end

    before do
      sign_in user
      visit groups_path
    end

    it 'displays the groups' do
      expect(page).to have_content('Subway')
      expect(page).to have_content('Mac donalds')
    end

    it 'displays the group icons' do
      expect(page).to have_css("img[src*='https://i.pinimg.com/originals/4b/eb/2a/4beb2a37a5810f9eacc37e3c6234889c.png']")
      expect(page).to have_css("img[src*='https://es.logodownload.org/wp-content/uploads/2018/11/McDonalds-logo-11.png']")
    end

    it 'links to the group show page' do
      click_link 'Subway'
      expect(page).to have_content('TRANSACTIONS')
    end

    it 'displays the total purchases for each group' do
      expect(page).to have_content('$0')
    end

    it 'displays the "ADD A NEW CATEGORY" button' do
      expect(page).to have_link('ADD A NEW CATEGORY', href: new_group_path)
    end

    it 'does not display the splash screen' do
      expect(page).to_not have_content('Welcome to the app!')
    end

    it 'does not display the navbar with logout and search for unauthorized users' do
      sign_out user
      visit groups_path
      expect(page).to_not have_content('Logout')
      expect(page).to_not have_content('Search')
    end
  end
end