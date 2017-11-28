require 'rails_helper'

RSpec.describe Api::V1::CompaniesController, type: :request do
  let!(:company) { create(:company,
    id: 1,
    email: 'info@building.se',
    name: 'BraBra Bygg',
    username: 'Anders P',
    address: 'Södra 33',
    zip_code: 412,
    city: 'Göteborg',
    org_number: '1111',
    phone: '1111',
    contact: 'Anders',
    invoice_address: 'Södra 33',
    created_at: '2017-12-30',
    updated_at: '2017-12-31'
  )}

  describe 'GET /v1/companies' do
    it 'should return all the companies with content' do
      get '/api/v1/companies'

      expected_response = [{
        'id' => company.id,
        'email' => 'info@building.se',
        'name' => 'BraBra Bygg',
        'username' => 'Anders P',
        'address' => 'Södra 33',
        'zip_code' => 412,
        'city' => 'Göteborg',
        'org_number' => '1111',
        'phone' => '1111',
        'contact' => 'Anders',
        'invoice_address' => 'Södra 33',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z'
      }]

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end
  end

  describe 'GET /v1/companies' do
    it 'should return the companies content' do
      get "/api/v1/companies/#{company.id}"

      expected_response = {
        'id' => company.id,
        'email' => 'info@building.se',
        'name' => 'BraBra Bygg',
        'username' => 'Anders P',
        'address' => 'Södra 33',
        'zip_code' => 412,
        'city' => 'Göteborg',
        'org_number' => '1111',
        'phone' => '1111',
        'contact' => 'Anders',
        'invoice_address' => 'Södra 33',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z'
      }

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end

    it 'should render error message on failure' do
      get '/api/v1/companies/999999'
      expected_response = {message: "Couldn't find Company with 'id'=999999"}
      expect(response_json).to eq JSON.parse(expected_response.to_json)
      expect(response.status).to eq 404
    end
  end
end
