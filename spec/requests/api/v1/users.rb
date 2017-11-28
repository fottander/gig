require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let!(:user) { create(:user,
    id: 1,
    email: 'felix.ottander@yahoo.com',
    first_name: 'Felix',
    last_name: 'Ottander',
    phone: '5555',
    bank: 'Nordea',
    clear_nr: '1111',
    account_nr: '1111',
    created_at: '2017-12-30',
    updated_at: '2017-12-31'
  )}

  describe 'GET /v1/users' do
    it 'should return all the users with content' do
      get '/api/v1/users'

      expected_response = [{
        'id' => user.id,
        'email' => 'felix.ottander@yahoo.com',
        'first_name' => 'Felix',
        'last_name' => 'Ottander',
        'phone' => '5555',
        'bank' => 'Nordea',
        'clear_nr' => '1111',
        'account_nr' => '1111',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z'
      }]

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end
  end

  describe 'GET /v1/users' do
    it 'should return the users content' do
      get "/api/v1/users/#{user.id}"

      expected_response = {
        'id' => user.id,
        'email' => 'felix.ottander@yahoo.com',
        'first_name' => 'Felix',
        'last_name' => 'Ottander',
        'phone' => '5555',
        'bank' => 'Nordea',
        'clear_nr' => '1111',
        'account_nr' => '1111',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z'
      }

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end

    it 'should render error message on failure' do
      get '/api/v1/users/999999'
      expected_response = {message: "Couldn't find User with 'id'=999999"}
      expect(response_json).to eq JSON.parse(expected_response.to_json)
      expect(response.status).to eq 404
    end
  end
end
