require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :message }
    it { is_expected.to have_db_column(:status).of_type(:boolean) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :message }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :profile }
    it { is_expected.to belong_to :job }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:application)).to be_valid
    end
  end
end
