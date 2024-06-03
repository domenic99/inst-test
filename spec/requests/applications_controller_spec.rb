require 'rails_helper'

RSpec.describe 'Application requests', type: :request do
  describe 'GET /api/v1/applications' do
    subject(:perform_request) { get '/api/v1/applications' }

    let(:job) { create(:job) }
    let!(:application) { create(:application, job: job) }

    context 'with active job' do
      before { create(:job_event_activate, job: job) }

      it 'returns applications' do
        perform_request

        expect(response).to have_http_status(200)
        expect(json.size).to eq(1)
      end

      context 'with application with notes' do
        before { create_list(:application_event_note, 2, application: application) }

        it 'returns a list with application details' do
          perform_request

          expect(json.first['id']).to eq(application.id)
          expect(json.first['status']).to eq('applied')
          expect(json.first['notes_count']).to eq(2)
          expect(json.first['last_interview_date']).to eq(nil)
        end
      end

      context 'with application with multiple interviews' do
        let!(:first_interview) do
          create(:application_event_interview, application: application, interview_date: Faker::Date.unique.backward)
        end
        let!(:second_interview) do
          create(:application_event_interview, application: application,
                 interview_date: first_interview.interview_date + 1.day)
        end

        it 'returns applications' do
          perform_request

          expect(response).to have_http_status(200)
          expect(json.size).to eq(1)
        end

        it 'returns a list with application details' do
          perform_request

          expect(json.first['id']).to eq(application.id)
          expect(json.first['status']).to eq('interview')
          expect(json.first['notes_count']).to eq(0)
          expect(json.first['last_interview_date']).to eq(second_interview.interview_date.to_s)
        end
      end
    end

    context 'with deactivated job' do
      before { create(:job_event_deactivate, job: job) }

      it 'returns applications' do
        perform_request

        expect(response).to have_http_status(200)
        expect(json.size).to eq(0)
      end
    end
  end
end
