require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :first_name }
    it { is_expected.to have_db_column :last_name }
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :phone}
    it { is_expected.to have_db_column :bank}
    it { is_expected.to have_db_column :clear_nr}
    it { is_expected.to have_db_column :account_nr}
    it { is_expected.to have_db_column :pers_num}
    it { is_expected.to have_db_column :encrypted_pers_num}
    it { is_expected.to have_db_column :encrypted_pers_num_iv}
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
  end

  describe 'Associations' do
    it { is_expected.to have_one :profile }
    it { is_expected.to have_many :invoices }
    it { is_expected.to have_many :ezinvoices }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:user, first_name: 'felix', last_name: 'ottander')).to be_valid
    end
  end
end
