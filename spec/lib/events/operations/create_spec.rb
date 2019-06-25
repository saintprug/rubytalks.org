# frozen_string_literal: true

RSpec.describe Events::Operations::Create do
  subject { operation.call(event_form) }

  let(:operation) { described_class.new(event_repo: event_repo) }
  let(:event_repo) { instance_double('EventRepository', create: Event.new) }
  let(:event_form) { Fabricate.attributes_for(:event).symbolize_keys }

  context 'when event form is valid' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Event) }
  end

  context 'when event has not created' do
    let(:event_repo) { instance_double('EventRepository', create: nil) }

    it { expect(subject).to be_failure }
  end

  context 'with real data' do
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Event) }
    it { expect { subject }.to change { EventRepository.new.all.count }.by(1) }
  end
end
