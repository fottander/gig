require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :name }
    it { is_expected.to have_db_column :username }
    it { is_expected.to have_db_column :address }
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :zip_code }
    it { is_expected.to have_db_column :city }
    it { is_expected.to have_db_column :org_number }
    it { is_expected.to have_db_column :phone }
    it { is_expected.to have_db_column :invoice_address }
    it { is_expected.to have_db_column :employees }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :real }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :username }
    it { should validate_uniqueness_of(:username) }
    it { is_expected.to validate_presence_of :address }
    it { is_expected.to validate_presence_of :zip_code }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :org_number }
    it { is_expected.to validate_presence_of :phone }
  end

  describe 'Associations' do
    it { is_expected.to have_many :jobs }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:company)).to be_valid
    end
  end
end
