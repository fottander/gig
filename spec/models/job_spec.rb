require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :requirement }
    it { is_expected.to have_db_column :category }
    it { is_expected.to have_db_column :city }
    it { is_expected.to have_db_column :budget }
    it { is_expected.to have_db_column :deadline }
    it { is_expected.to have_db_column :duration }
    it { is_expected.to have_db_column :hour_week }
    it { is_expected.to have_db_column(:active).of_type(:boolean) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :category }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :budget }
    it { is_expected.to validate_presence_of :deadline }
    it { is_expected.to validate_presence_of :duration }
    it { is_expected.to validate_presence_of :hour_week }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :company }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:job)).to be_valid
    end
  end
end