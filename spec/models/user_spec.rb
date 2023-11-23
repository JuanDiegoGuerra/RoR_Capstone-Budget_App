require './spec/rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Juan', email: 'juan@gmail.com', password: 'password', password_confirmation: 'password') }

  context 'Validation' do
    it 'should be valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'should have the name present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should have a maximum name length of 50 characters' do
      subject.name = 'x' * 51
      expect(subject).to_not be_valid
    end
  end

  context 'Associations' do
    it 'should have many groups' do
      association = described_class.reflect_on_association(:groups)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('author_id')
    end

    it 'should have many purchases' do
      association = described_class.reflect_on_association(:purchases)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:foreign_key]).to eq('author_id')
    end
  end

  context 'Devise Configuration' do
    it 'should include devise modules' do
      expect(described_class.devise_modules).to include(:database_authenticatable, :registerable, :recoverable,
                                                        :rememberable, :validatable)
    end
  end
end