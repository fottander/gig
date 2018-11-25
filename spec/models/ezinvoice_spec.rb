require 'rails_helper'

RSpec.describe Ezinvoice, type: :model do
  describe 'DB table' do
    it { is_expected.to have_db_column :org_number }
    it { is_expected.to have_db_column :company_name }
    it { is_expected.to have_db_column :company_address }
    it { is_expected.to have_db_column :company_zip }
    it { is_expected.to have_db_column :company_city }
    it { is_expected.to have_db_column :company_email }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column(:unit).of_type(:integer) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_column(:amount).of_type(:integer) }
    it { is_expected.to have_db_column :first_day }
    it { is_expected.to have_db_column :last_day }
    it { is_expected.to have_db_column :ocr_number }
    it { is_expected.to have_db_column(:soc_avgift).of_type(:float) }
    it { is_expected.to have_db_column(:age).of_type(:integer) }
    it { is_expected.to have_db_column :user_fee }
    it { is_expected.to have_db_column :user_reference }
    it { is_expected.to have_db_column :company_reference }
    it { is_expected.to have_db_column :terms }
    it { is_expected.to have_db_column :ssyk_code }
    it { is_expected.to have_db_column :profile_id }
    it { is_expected.to have_db_column :profile_username }
    it { is_expected.to have_db_column(:paid).of_type(:boolean) }
    it { is_expected.to have_db_column(:salary_paid).of_type(:boolean) }
    it { is_expected.to have_db_column(:post).of_type(:boolean) }
    it { is_expected.to have_db_column :soc_avgift_m_age }
    it { is_expected.to have_db_column :bruttolon }
    it { is_expected.to have_db_column :nettolon }
    it { is_expected.to have_db_column :loneskatt }
    it { is_expected.to have_db_column :arbetsgivaravgifter }
    it { is_expected.to have_db_column :sociala_avgifter }
    it { is_expected.to have_db_column :pension_loneskatt }
    it { is_expected.to have_db_column :fakturabelopp }
    it { is_expected.to have_db_column :varavgift }
    it { is_expected.to have_db_column :bruttolon_ef_avg }
    it { is_expected.to have_db_column :bruttol_exkl_semester_ef_avg }
    it { is_expected.to have_db_column :arbetsgivaravgifter_ef_avg }
    it { is_expected.to have_db_column :sociala_avgifter_ef_avg }
    it { is_expected.to have_db_column :fakturabelopp_inklmoms }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :org_number }
    it { is_expected.to validate_presence_of :user_fee }
    it { is_expected.to validate_presence_of :terms }
    it { is_expected.to validate_presence_of :company_name }
    it { is_expected.to validate_presence_of :company_address }
    it { is_expected.to validate_presence_of :company_zip }
    it { is_expected.to validate_presence_of :company_city }
    it { is_expected.to validate_presence_of :company_email }
    it { is_expected.to validate_presence_of :company_reference }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :quantity }
    it { is_expected.to validate_presence_of :unit }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :user_reference }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:ezinvoice)).to be_valid
    end
  end
end
