# frozen_string_literal: true

RSpec.describe Events::Operations::List do
  subject { operation.call({}) }

  let(:operation) { described_class.new(event_repo: event_repo) }
  let(:event_repo) { instance_double('EventRepository', latest: Fabricate.build_times(3, :event)) }

  context 'when events exist' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.length).to eq(3) }
  end

  context 'when there are no events' do
    let(:event_repo) { instance_double('EventRepository', latest: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.length).to eq(0) }
  end

  context 'with real data' do
    let!(:events) { Fabricate.times(3, :event) }
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.map(&:id)).to include(*events.map(&:id)) }
  end
end
