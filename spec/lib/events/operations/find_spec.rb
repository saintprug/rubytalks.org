# frozen_string_literal: true

RSpec.describe Events::Operations::Find do
  subject { operation.call(id: 1) }

  let(:operation) { described_class.new(event_repo: event_repo) }
  let(:event_repo) { instance_double('EventRepository', find_with_talks: Event.new) }

  context 'when event exists' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Event) }
  end

  context 'when event does not exist' do
    let(:event_repo) { instance_double('EventRepository') }

    before { allow(event_repo).to receive(:find_with_talks).and_raise(ROM::TupleCountMismatchError) }

    it { expect(subject).to be_failure }
  end

  context 'with real data' do
    subject { operation.call(id: event.id) }

    let(:event) { Fabricate.create(:event) }
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Event) }
  end
end
