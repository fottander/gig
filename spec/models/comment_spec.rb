require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :comment }
    it { is_expected.to have_db_column :application_id }
    it { is_expected.to have_db_column :profile_id }
    it { is_expected.to have_db_column :company_id }
    it { is_expected.to have_db_column :profile_username}
    it { is_expected.to have_db_column :company_username }
    it { is_expected.to have_db_column :job_id }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :comment }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :application }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:comment)).to be_valid
    end
  end
end
