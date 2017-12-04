require 'rails_helper'

RSpec.describe Category, type: :model do
    describe 'DB table' do
      it { is_expected.to have_db_column :name }
    end

    describe 'Validations' do
      it { is_expected.to validate_presence_of :name }
    end

    describe 'Associations' do
      it { should have_and_belong_to_many(:profiles) }
      it { should have_and_belong_to_many(:jobs) }
    end

    describe 'Factory' do
      it 'should have valid Factory' do
        expect(create(:category)).to be_valid
      end
    end
  end
