require 'rails_helper'

RSpec.describe Ezinvoice, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :org_number }
    it { is_expected.to have_db_column :company_name }
    it { is_expected.to have_db_column :company_address }
    it { is_expected.to have_db_column :company_zip }
    it { is_expected.to have_db_column :company_city }
    it { is_expected.to have_db_column :company_email }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :quantity }
    it { is_expected.to have_db_column :unit }
    it { is_expected.to have_db_column :amount }
    it { is_expected.to have_db_column :first_day }
    it { is_expected.to have_db_column :last_day }
    it { is_expected.to have_db_column :ocr_number }
    it { is_expected.to have_db_column :user_reference }
    it { is_expected.to have_db_column :company_reference }
    it { is_expected.to have_db_column :terms }
    it { is_expected.to have_db_column :profile_id }
    it { is_expected.to have_db_column :profile_username }
    it { is_expected.to have_db_column(:paid).of_type(:boolean) }
    it { is_expected.to have_db_column(:active).of_type(:boolean) }
    it { is_expected.to have_db_column(:salary_paid).of_type(:boolean) }
    it { is_expected.to have_db_column(:post).of_type(:boolean) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :org_number }
    it { is_expected.to validate_presence_of :company_name }
    it { is_expected.to validate_presence_of :company_address }
    it { is_expected.to validate_presence_of :company_zip }
    it { is_expected.to validate_presence_of :company_city }
    it { is_expected.to validate_presence_of :company_email }
    it { is_expected.to validate_presence_of :company_reference }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :user_reference }
    it { is_expected.to validate_presence_of :profile_id }
    it { is_expected.to validate_presence_of :profile_username }
    it { is_expected.to validate_presence_of :user_id }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:invoice)).to be_valid
    end
  end
end
