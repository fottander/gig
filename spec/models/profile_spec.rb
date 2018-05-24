require 'rails_helper'

RSpec.describe Profile, type: :model do

  before(:all) do
    Category.destroy_all
    create(:category, name: 'Målare', id: 100)
    create(:category, name: 'Snickare', id: 200)
    City.destroy_all
    create(:city, name: 'Göteborg', id: 100)
    create(:city, name: 'Stockholm', id: 200)
  end

  describe 'DB table' do
    it { is_expected.to have_db_column :username }
    it { is_expected.to have_db_column :title }
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
    it { is_expected.to validate_presence_of :username }
    it { should validate_uniqueness_of(:username) }
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :category_ids }
    it { is_expected.to validate_presence_of :city_ids }
    it { is_expected.to validate_presence_of :age }
    it { should validate_length_of(:title).is_at_most(50) }
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
      expect(create(:profile, category_ids: '100', city_ids: '100')).to be_valid
    end
  end

  it 'has an avatar url by default' do
    profile = create(:profile, category_ids: '200', city_ids: '200')
    expect(profile.avatar.url).to include 'Default-avatar.png'
  end
end
