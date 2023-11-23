require 'rails_helper'

RSpec.describe '_splash_screen', type: :system do
  describe '_splash_screen page' do
    before do
      visit groups_path
    end

    it 'displays the app name' do
      expect(page).to have_content('Budget App')
    end

    it 'displays the login link' do
      expect(page).to have_link('Log in', href: new_user_session_path)
    end

    it 'displays the sign up link' do
      expect(page).to have_link('Sign up', href: new_user_registration_path)
    end
  end
end