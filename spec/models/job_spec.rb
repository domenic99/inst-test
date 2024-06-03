require 'rails_helper'

RSpec.describe Job, type: :model do
  describe '.active' do
    subject { described_class.active }

    let(:job) { create(:job) }

    before { create(:job_event, job: job) }

    context 'when last job event is activate' do
      before { create(:job_event_activate, job: job) }

      it { is_expected.to include(job) }
    end

    context 'when last job event is deactivate' do
      before { create(:job_event_deactivate, job: job) }

      it { is_expected.not_to include(job) }
    end
  end
end
