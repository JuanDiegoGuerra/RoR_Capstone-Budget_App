require './spec/rails_helper'

RSpec.describe Group, type: :model do
  let!(:user) do
    User.create(name: 'Juan', email: 'juan@gmail.com', password: 'password', password_confirmation: 'password')
  end
  subject { Group.new(name: 'Subway', icon: 'https://i.pinimg.com/originals/4b/eb/2a/4beb2a37a5810f9eacc37e3c6234889c.png', author_id: user.id) }

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'should have the name present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should have a maximum name length of 60 characters' do
      subject.name = 'x' * 61
      expect(subject).to_not be_valid
    end

    it 'should have the icon present' do
      subject.icon = nil
      expect(subject).to_not be_valid
    end
  end

  context 'Associations' do
    it 'should belong to an author' do
      association = described_class.reflect_on_association(:author)
      expect(association.macro).to eq(:belongs_to)
      expect(association.class_name).to eq('User')
    end

    it 'should have and belong to many purchases' do
      association = described_class.reflect_on_association(:purchases)
      expect(association.macro).to eq(:has_and_belongs_to_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end