require 'rails_helper'

RSpec.describe Api::V1::ApplicationsController, type: :request do
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
  let!(:category) { create(:category,
    id: 1,
    name: 'Målare'
  )}
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
  let!(:profile) { create(:profile,
    id: 1,
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
  let!(:job) { create(:job,
    id: 1,
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
  let!(:application) { create(:application,
    id: 1,
    message: 'Hej jag vill ha jobb',
    hired: false,
    complete: false,
    job_id: 1,
    profile_id: 1,
    profile_username: 'Fisken',
    job_title: 'Målare sökes',
    created_at: '2017-12-30',
    updated_at: '2017-12-31'
  )}

  describe 'GET /v1/jobs/1/applications' do
    it 'should return the jobs application' do
      get "/api/v1/jobs/#{job.id}/applications"

      expected_response = [{
        'id' => application.id,
        'message' => 'Hej jag vill ha jobb',
        'hired' => false,
        'complete' => false,
        'job_id' => 1,
        'profile_id' => 1,
        'profile_username' => 'Fisken',
        'job_title' => 'Målare sökes',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z'
      }]

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end
  end

  describe 'GET /v1/jobs/applications' do
    it 'should return the applications content' do
      get "/api/v1/jobs/#{job.id}/applications/#{application.id}"

      expected_response = {
        'id' => application.id,
        'message' => 'Hej jag vill ha jobb',
        'hired' => false,
        'complete' => false,
        'job_id' => 1,
        'profile_id' => 1,
        'profile_username' => 'Fisken',
        'job_title' => 'Målare sökes',
        'created_at' => '2017-12-30T00:00:00.000Z',
        'updated_at' => '2017-12-31T00:00:00.000Z'
      }

      expect(response_json).to eq expected_response
      expect(response.status).to eq 200
    end

    it 'should render error message on failure' do
      get '/api/v1/jobs/1/applications/999999'
      expected_response = {message: "Couldn't find Application with 'id'=999999"}
      expect(response_json).to eq JSON.parse(expected_response.to_json)
      expect(response.status).to eq 404
    end
  end
end
