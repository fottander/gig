require 'rails_helper'

RSpec.describe Invite, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :message }
    it { is_expected.to have_db_column :job_title }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :message }
    it { is_expected.to validate_presence_of :job_title }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :profile }
    it { is_expected.to belong_to :company }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:invite)).to be_valid
    end
  end
end
