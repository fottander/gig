require 'rails_helper'

RSpec.describe Job, type: :model do

  before(:all) do
    Category.destroy_all
    create(:category, name: 'Målare', id: 100)
    create(:category, name: 'Snickare', id: 200)
    City.destroy_all
    create(:city, name: 'Göteborg', id: 100)
    create(:city, name: 'Stockholm', id: 200)
  end

  describe 'DB table' do
    it { is_expected.to have_db_column :title }
    it { is_expected.to have_db_column :description }
    it { is_expected.to have_db_column :requirement }
    it { is_expected.to have_db_column :budget }
    it { is_expected.to have_db_column :deadline }
    it { is_expected.to have_db_column :duration }
    it { is_expected.to have_db_column :jobtype }
    it { is_expected.to have_db_column :when_in_time }
    it { is_expected.to have_db_column :hour_day }
    it { is_expected.to have_db_column(:active).of_type(:boolean) }
    it { is_expected.to have_db_column :company_id }
    it { is_expected.to have_db_column :company_city }
    it { is_expected.to have_db_column :company_username }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :duration }
    it { is_expected.to validate_presence_of :when_in_time }
    it { is_expected.to validate_presence_of :hour_day }
    it { is_expected.to validate_presence_of :jobtype }
    it { is_expected.to validate_presence_of :category_ids }
    it { is_expected.to validate_presence_of :city_ids }
    it { should validate_length_of(:title).is_at_most(50) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to :company }
    it { is_expected.to have_many :applications}
    it { should have_and_belong_to_many(:categories) }
    it { should have_and_belong_to_many(:cities) }
  end

  describe 'Factory' do
    it 'should have valid Factory' do
      expect(create(:job, category_ids: '100', city_ids: '100')).to be_valid
    end
  end
end
