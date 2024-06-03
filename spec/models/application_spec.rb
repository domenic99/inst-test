require 'rails_helper'

RSpec.describe Application, type: :model do
  describe '#status' do
    subject { application.status }

    let(:application) { create(:application) }

    context 'when last application event is interview' do
      before { create(:application_event_interview, application: application) }

      it { is_expected.to eq(:interview) }
    end

    context 'when last application event is hire' do
      before { create(:application_event_hire, application: application) }

      it { is_expected.to eq(:hired) }
    end

    context 'when last application event is reject' do
      before { create(:application_event_reject, application: application) }

      it { is_expected.to eq(:rejected) }
    end

    context 'when last application event is note' do
      context 'when there is an event before note' do
        before { create(:application_event_hire, application: application) }

        it 'has status depend on event before note' do
          is_expected.to eq(:hired)
        end
      end

      context 'when there is no events before note' do
        it { is_expected.to eq(Application::DEFAULT_APPLICATION_STATUS) }
      end
    end

    context 'when there is no event' do
      it { is_expected.to eq(Application::DEFAULT_APPLICATION_STATUS) }
    end
  end
end
