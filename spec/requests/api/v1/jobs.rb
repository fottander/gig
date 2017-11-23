require 'rails_helper'

RSpec.describe Api::V1::JobsController, type: :request do
  let!(:company) { create(:company,
    id: 1,
    email: 'info@building.se',
    name: 'Gbghus',
    username: 'Anders P',
    address: 'Södra 33',
    zip_code: '412',
    city: 'Göteborg',
    org_number: '12345',
    phone: '0733',
    contact: 'Anders'
  )}
  let!(:job) { create(:job,
    title: 'Målare sökes',
    description: 'Duktig målare sökes',
    category: 'Målare',
    city: 'Göteborg', budget: '140',
    deadline: '2018-01-01',
    duration: '2 veckor',
    hour_week: 45,
    requirement: 'Målning 5år',
    active: false,
    company_id: 1,
    company_city: 'Göteborg',
    created_at: '2017-12-30',
    updated_at: '2017-12-31'
  )}

  describe 'GET /v1/jobs' do
    it 'should return all the jobs with content' do
      get '/api/v1/jobs'

      expected_response = [{
        'id' => job.id, 'title' => 'Målare sökes',
        'description' => 'Duktig målare sökes',
        'category' => 'Målare',
        'city' => 'Göteborg',
        'budget' => '140',
        'deadline' => '2018-01-01',
        'duration' => '2 veckor',
        'hour_week' => 45,
        'requirement' => 'Målning 5år',
        'active' => false,
        'company_id' => 1,
        'company_city' => 'Göteborg',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z'
      }]

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end
  end

  describe 'GET /v1/jobs' do
    it 'should return the jobs title,description and other content' do
      get "/api/v1/jobs/#{job.id}"

      expected_response = {
        'id' => job.id, 'title' => 'Målare sökes',
        'description' => 'Duktig målare sökes',
        'category' => 'Målare',
        'city' => 'Göteborg',
        'budget' => '140',
        'deadline' => '2018-01-01',
        'duration' => '2 veckor',
        'hour_week' => 45,
        'requirement' => 'Målning 5år',
        'active' => false,
        'company_id' => 1,
        'company_city' => 'Göteborg',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z'
      }

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end

    it 'should render error message on failure' do
      get '/api/v1/jobs/999999'
      expected_response = {message: "Couldn't find Job with 'id'=999999"}
      expect(response_json).to eq JSON.parse(expected_response.to_json)
      expect(response.status).to eq 404
    end
  end
end
