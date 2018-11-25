require 'rails_helper'

RSpec.describe Invoice, type: :model do

  before(:all) do
    Company.destroy_all
    create(:company, name: 'bygg ab', id: 100)
    User.destroy_all
    create(:user, email: 'greger@greger.se', first_name: 'felix', last_name: 'ottander', id: 100)
  end

  describe 'DB table' do
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column(:unit).of_type(:integer) }
    it { is_expected.to have_db_column(:quantity).of_type(:integer) }
    it { is_expected.to have_db_column(:amount).of_type(:integer) }
    it { is_expected.to have_db_column :first_day }
    it { is_expected.to have_db_column :last_day }
    it { is_expected.to have_db_column :ocr_number }
    it { is_expected.to have_db_column :user_reference }
    it { is_expected.to have_db_column :company_reference }
    it { is_expected.to have_db_column :terms }
    it { is_expected.to have_db_column :user_fee }
    it { is_expected.to have_db_column :feedback }
    it { is_expected.to have_db_column(:invoice_fees).of_type(:integer) }
    it { is_expected.to have_db_column(:soc_avgift).of_type(:float) }
    it { is_expected.to have_db_column(:age).of_type(:integer) }
    it { is_expected.to have_db_column(:rating).of_type(:float) }
    it { is_expected.to have_db_column(:paid).of_type(:boolean) }
    it { is_expected.to have_db_column(:salary_paid).of_type(:boolean) }
    it { is_expected.to have_db_column(:post).of_type(:boolean) }
    it { is_expected.to have_db_column :application_id }
    it { is_expected.to have_db_column :job_id }
    it { is_expected.to have_db_column :ssyk_code }
    it { is_expected.to have_db_column :job_title }
    it { is_expected.to have_db_column :profile_id }
    it { is_expected.to have_db_column :profile_username }
    it { is_expected.to have_db_column :bruttolon }
    it { is_expected.to have_db_column :nettolon }
    it { is_expected.to have_db_column :loneskatt }
    it { is_expected.to have_db_column :arbetsgivaravgifter }
    it { is_expected.to have_db_column :sociala_avgifter }
    it { is_expected.to have_db_column :pension_loneskatt }
    it { is_expected.to have_db_column :fakturabelopp }
    it { is_expected.to have_db_column :fakturabelopp_frilansare }
    it { is_expected.to have_db_column :varavgift }
    it { is_expected.to have_db_column :bruttolon_ef_avg }
    it { is_expected.to have_db_column :arbetsgivaravgifter_ef_avg }
    it { is_expected.to have_db_column :sociala_avgifter_ef_avg }
    it { is_expected.to have_db_column :fakturabelopp_inklmoms }
    it { is_expected.to have_db_column :totalbelopp }
    it { is_expected.to have_db_column :totalbelopp_inklmoms }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :amount }
    it { is_expected.to validate_presence_of :quantity }
    it { is_expected.to validate_presence_of :unit }
    it { is_expected.to validate_presence_of :user_reference }
    it { is_expected.to validate_presence_of :job_id }
    it { is_expected.to validate_presence_of :job_title }
    it { is_expected.to validate_presence_of :invoice_fees }
    it { is_expected.to validate_presence_of :application_id }
    it { is_expected.to validate_presence_of :user_fee }
    it { is_expected.to validate_presence_of :terms }
    it { is_expected.to validate_presence_of :profile_id }
    it { is_expected.to validate_presence_of :profile_username }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :company }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:invoice, user_id: 100, company_id: 100, user_id: 100)).to be_valid
    end
  end
end
