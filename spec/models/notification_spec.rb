require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :recipient_id }
    it { is_expected.to have_db_column :actor_id }
    it { is_expected.to have_db_column :job_id }
    it { is_expected.to have_db_column :application_id }
    it { is_expected.to have_db_column :action }
    it { is_expected.to have_db_column :notifiable_id }
    it { is_expected.to have_db_column :notifiable_type }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :recipient_id }
    it { is_expected.to validate_presence_of :actor_id }
    it { is_expected.to validate_presence_of :job_id }
    it { is_expected.to validate_presence_of :action }
    it { is_expected.to validate_presence_of :notifiable_type }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :recipient }
    it { is_expected.to belong_to :actor }
    it { is_expected.to belong_to :notifiable }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:notification)).to be_valid
    end
  end
end
