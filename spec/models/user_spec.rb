require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :first_name }
    it { is_expected.to have_db_column :last_name }
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :phone}
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :email }
  end

  describe 'Custom validations' do
    it 'cannot set a non-approved role' do
      subject.role = 'clown'
      subject.save
      expect(subject.errors.full_messages).to include 'Role clown is not a valid user role'
    end
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:user)).to be_valid
    end
  end
end
