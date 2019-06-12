# frozen_string_literal: true

RSpec.describe Web::Controllers::Events::Index do
  subject { action.call(params) }

  let(:params) { {} }
  let(:action) { described_class.new(operation: operation) }

  context 'when operation is success' do
    let(:events) { Fabricate.build_times(3, :event) }
    let(:operation) { ->(*) { Success(events) } }

    it { expect(subject.first).to eq(200) }

    it 'exposes events' do
      subject
      expect(action.events).to eq(events)
    end
  end

  context 'with real data' do
    let!(:events) { Fabricate.times(3, :event) }
    let(:action) { described_class.new }

    it { expect(subject.first).to eq(200) }

    it 'exposes events' do
      subject
      expect(action.events).to match_array(events)
    end
  end
end
