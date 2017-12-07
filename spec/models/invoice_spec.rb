require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'DB table' do
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
    it { is_expected.to have_db_column :feedback }
    it { is_expected.to have_db_column(:paid).of_type(:boolean) }
    it { is_expected.to have_db_column(:active).of_type(:boolean) }
    it { is_expected.to have_db_column(:post).of_type(:boolean) }
    it { is_expected.to have_db_column :application_id }
    it { is_expected.to have_db_column :job_id }
    it { is_expected.to have_db_column :profile_id }
    it { is_expected.to have_db_column :profile_username }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :user_reference }
    it { is_expected.to validate_presence_of :ocr_number }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :company }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:invoice)).to be_valid
    end
  end
end
