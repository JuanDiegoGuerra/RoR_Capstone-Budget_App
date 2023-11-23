require 'rails_helper'

RSpec.describe 'Groups', type: :system do
  describe 'Show page' do
    let!(:user) do
      User.create(name: 'Juan', email: 'juan@gmail.com', password: 'password', password_confirmation: 'password')
    end

    let!(:group) do
      Group.create(name: 'Subway',
                   icon: 'https://i.pinimg.com/originals/4b/eb/2a/4beb2a37a5810f9eacc37e3c6234889c.png',
                   author_id: user.id)
    end

    let!(:purchase) do
      pur = Purchase.create(name: 'Sandwich', amount: 1.5, author_id: user.id)
      group.purchases << pur
    end

    before do
      sign_in user
      visit group_path(group.id)
    end

    it 'displays the group icon' do
      expect(page).to have_css("img[src*='https://i.pinimg.com/originals/4b/eb/2a/4beb2a37a5810f9eacc37e3c6234889c.png']")
    end

    it 'displays the group name' do
      expect(page).to have_content('Subway')
    end

    it 'displays the remove button' do
      expect(page).to have_button('Remove')
    end

    it 'displays the total payment for the group' do
      expect(page).to have_content('$1.5')
    end

    it 'displays the purchases for the group' do
      expect(page).to have_content('Sandwich')
      expect(page).to have_content('$1.5')
    end

    it 'displays the "ADD TRANSACTION" button' do
      expect(page).to have_link('ADD NEW TRANSACTION', href: new_group_purchase_path(group.id))
    end
  end
end