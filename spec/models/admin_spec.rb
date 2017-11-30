require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :encrypted_password }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :email }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:admin)).to be_valid
    end
  end
end
