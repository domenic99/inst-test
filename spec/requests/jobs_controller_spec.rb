require 'rails_helper'

RSpec.describe 'Job requests', type: :request do
  describe 'GET /jobs' do
    let(:job) { create(:job) }

    before do
      create(:job_event_activate, job: job)
      create(:application_event_hire, application: create(:application, job: job))
      create(:application_event_reject, application: create(:application, job: job))
      create(:application_event_interview, application: create(:application, job: job))
      create(:application_event_note, application: create(:application, job: job))

      get '/api/v1/jobs'
    end

    it 'returns jobs' do
      expect(response).to have_http_status(200)
      expect(json.size).to eq(1)
    end

    it 'returns a list with job details' do

      expect(json.first['id']).to eq(job.id)
      expect(json.first['status']).to eq('activated')
      expect(json.first['hired_candidates_count']).to eq(1)
      expect(json.first['rejected_candidates_count']).to eq(1)
      expect(json.first['ongoing_candidates_count']).to eq(2)
    end
  end
end
