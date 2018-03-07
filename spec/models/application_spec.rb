require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :message }
    it { is_expected.to have_db_column :first_day }
    it { is_expected.to have_db_column :last_day }
    it { is_expected.to have_db_column :job_id }
    it { is_expected.to have_db_column :profile_id }
    it { is_expected.to have_db_column :profile_username }
    it { is_expected.to have_db_column :job_title }
    it { is_expected.to have_db_column :company_id }
    it { is_expected.to have_db_column(:hired).of_type(:boolean) }
    it { is_expected.to have_db_column(:complete).of_type(:boolean) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :message }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :profile }
    it { is_expected.to belong_to :job }
    it { is_expected.to have_many :comments }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:application)).to be_valid
    end
  end
end
