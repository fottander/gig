require 'rails_helper'

RSpec.describe Profile, type: :model do

  before(:all) do
    Category.destroy_all
    create(:category, name: 'Målare', id: 100)
    create(:category, name: 'Snickare', id: 200)
    City.destroy_all
    create(:city, name: 'Göteborg', id: 100)
    create(:city, name: 'Stockholm', id: 200)
    User.destroy_all
    create(:user, email: 'greger@greger.se', first_name: 'felix', last_name: 'ottander', id: 100)
  end

  describe 'DB table' do
    it { is_expected.to have_db_column :username }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :skill }
    it { is_expected.to have_db_column :language }
    it { is_expected.to have_db_column :license }
    it { is_expected.to have_db_column :education }
    it { is_expected.to have_db_column :prev_work }
    it { is_expected.to have_db_column :user_id }
    it { is_expected.to have_db_column :age }
  end

  describe 'Validations' do
    it { expect(create(:profile, user_id: 100, category_ids: '100', city_ids: '100').username).to eq("Felix O")}
    it { expect(create(:profile, user_id: 100, category_ids: '100', city_ids: '100')).to validate_presence_of :age }
    it { expect(create(:profile, user_id: 100, category_ids: '100', city_ids: '100')).to validate_presence_of :description }
    it { expect(create(:profile, user_id: 100, category_ids: '100', city_ids: '100')).to validate_presence_of :category_ids }
    it { expect(create(:profile, user_id: 100, category_ids: '100', city_ids: '100')).to validate_presence_of :city_ids }
  end

  describe 'Avatar attachment' do
    it { is_expected.to have_attached_file(:avatar)}
  end

  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { should have_and_belong_to_many(:categories) }
    it { should have_and_belong_to_many(:cities) }
    it { is_expected.to have_many :applications}
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:profile, user_id: 100, category_ids: '100', city_ids: '100')).to be_valid
    end
  end

  it 'has an avatar url by default' do
    profile = create(:profile, user_id: 100, category_ids: '200', city_ids: '200')
    expect(profile.avatar.url).to include 'Default-avatar.png'
  end
end
