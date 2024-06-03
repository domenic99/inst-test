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
        before do
          create(:application_event_hire, application: application)
          create(:application_event_note, application: application)
        end

        it 'has status depend on event before note' do
          is_expected.to eq(:hired)
        end
      end

      context 'when there is no events before note' do
        before { create(:application_event_note, application: application) }

        it { is_expected.to eq(described_class::DEFAULT_APPLICATION_STATUS) }
      end
    end

    context 'when there is no event' do
      it { is_expected.to eq(described_class::DEFAULT_APPLICATION_STATUS) }
    end
  end

  describe '.hired' do
    subject { described_class.hired }

    let(:application) { create(:application) }

    context 'when last application event is hired' do
      before { create(:application_event_hire, application: application) }

      it { is_expected.to include(application) }
    end

    context 'when last application is note' do
      context 'when there is a hire event before note' do
        before do
          create(:application_event_hire, application: application)
          create(:application_event_note, application: application)
        end

        it { is_expected.to include(application) }
      end

      context 'when there is a different from hire event before note' do
        before do
          create(:application_event_interview, application: application)
          create(:application_event_note, application: application)
        end

        it { is_expected.not_to include(application) }
      end

      context 'when there is no events before note' do
        before { create(:application_event_note, application: application) }

        it { is_expected.not_to include(application) }
      end
    end

    context 'when last application is different from hired and note' do
      before { create(:application_event_interview, application: application) }

      it { is_expected.not_to include(application) }
    end

    context 'when there is no event' do
      it { is_expected.not_to include(application) }
    end
  end

  describe '.rejected' do
    subject { described_class.rejected }

    let(:application) { create(:application) }

    context 'when last application event is reject' do
      before { create(:application_event_reject, application: application) }

      it { is_expected.to include(application) }
    end

    context 'when last application is note' do
      context 'when there is a reject event before note' do
        before do
          create(:application_event_reject, application: application)
          create(:application_event_note, application: application)
        end

        it { is_expected.to include(application) }
      end

      context 'when there is a different from reject event before note' do
        before do
          create(:application_event_hire, application: application)
          create(:application_event_note, application: application)
        end

        it { is_expected.not_to include(application) }
      end

      context 'when there is no events before note' do
        before { create(:application_event_note, application: application) }

        it { is_expected.not_to include(application) }
      end
    end

    context 'when last application is different from reject and note' do
      before { create(:application_event_interview, application: application) }

      it { is_expected.not_to include(application) }
    end

    context 'when there is no event' do
      it { is_expected.not_to include(application) }
    end
  end

  describe '.ongoing' do
    subject { described_class.ongoing }

    let(:application) { create(:application) }

    context 'when last application event is reject' do
      before { create(:application_event_reject, application: application) }

      it { is_expected.not_to include(application) }
    end

    context 'when last application event is hire' do
      before { create(:application_event_hire, application: application) }

      it { is_expected.not_to include(application) }
    end

    context 'when last application event is note' do
      context 'when there is a reject event before note' do
        before do
          create(:application_event_reject, application: application)
          create(:application_event_note, application: application)
        end

        it { is_expected.not_to include(application) }
      end

      context 'when there is a hire event before note' do
        before do
          create(:application_event_hire, application: application)
          create(:application_event_note, application: application)
        end

        it { is_expected.not_to include(application) }
      end

      context 'when there is an interview event before note' do
        before do
          create(:application_event_interview, application: application)
          create(:application_event_note, application: application)
        end

        it { is_expected.to include(application) }
      end

      context 'when there is no events before note' do
        before { create(:application_event_note, application: application) }

        it { is_expected.to include(application) }
      end
    end

    context 'when last application event is interview' do
      before { create(:application_event_interview, application: application) }

      it { is_expected.to include(application) }
    end

    context 'when there is no events' do
      it { is_expected.to include(application) }
    end
  end
end
