require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :quantity }
    it { is_expected.to have_db_column :unit }
    it { is_expected.to have_db_column :amount }
    it { is_expected.to have_db_column :first_day }
    it { is_expected.to have_db_column :last_day }
    it { is_expected.to have_db_column :user_reference }
    it { is_expected.to have_db_column :company_reference }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :user_reference }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :application }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:invoice)).to be_valid
    end
  end
end
