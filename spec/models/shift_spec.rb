require 'rails_helper'

RSpec.describe Shift, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :start_date }
    it { is_expected.to have_db_column :end_date }
    it { is_expected.to have_db_column :start_time }
    it { is_expected.to have_db_column :end_time }
    it { is_expected.to have_db_column(:quantity).of_type(:float) }
    it { is_expected.to have_db_column(:ob_amount).of_type(:float) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :start_date }
    it { is_expected.to validate_presence_of :end_date }
    it { is_expected.to validate_presence_of :start_time }
    it { is_expected.to validate_presence_of :end_time }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :invoice }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:shift)).to be_valid
    end
  end
end
