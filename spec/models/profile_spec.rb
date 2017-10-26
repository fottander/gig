require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :username }
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :skill }
    it { is_expected.to have_db_column :rate }
    it { is_expected.to have_db_column :category }
    it { is_expected.to have_db_column :city }
    it { is_expected.to have_db_column :user_id }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :username }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :city }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:profile)).to be_valid
    end
  end
end
