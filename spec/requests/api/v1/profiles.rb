require 'rails_helper'

RSpec.describe Api::V1::ProfilesController, type: :request do
  let!(:user) { create(:user,
    id: 1,
    email: 'felix.ottander@yahoo.com',
    first_name: 'Felix',
    last_name: 'Ottander',
    phone: '34534535'
  )}
  let!(:category) { create(:category,
    id: 1,
    name: 'Målare'
  )}
  let!(:profile) { create(:profile,
    username: 'Fisken',
    title: 'Duktig målare',
    description: 'Duktig målare från gbg',
    skill: 'målare, snickare',
    rate: '140',
    city: 'Göteborg',
    created_at: '2017-12-30',
    updated_at: '2017-12-31',
    user_id: 1,
    category_ids: 1
  )}

  describe 'GET /v1/profiles' do
    it 'should return all the profiles with content' do
      get '/api/v1/profiles'

      expected_response = [{
        'id' => profile.id,
        'username' => 'Fisken',
        'title' => 'Duktig målare',
        'description' => 'Duktig målare från gbg',
        'skill' => 'målare, snickare',
        'rate' => '140',
        'city' => 'Göteborg',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z',
        'user_id' => 1,
        'category_ids' => [1]
      }]

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end
  end

  describe 'GET /v1/profiles' do
    it 'should return the profiles title,description and other content' do
      get "/api/v1/profiles/#{profile.id}"

      expected_response = {
        'id' => profile.id,
        'username' => 'Fisken',
        'title' => 'Duktig målare',
        'description' => 'Duktig målare från gbg',
        'skill' => 'målare, snickare',
        'rate' => '140',
        'city' => 'Göteborg',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z',
        'user_id' => 1,
        'category_ids' => [1]
      }

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end

    it 'should render error message on failure' do
      get '/api/v1/profiles/999999'
      expected_response = {message: "Couldn't find Profile with 'id'=999999"}
      expect(response_json).to eq JSON.parse(expected_response.to_json)
      expect(response.status).to eq 404
    end
  end
end
