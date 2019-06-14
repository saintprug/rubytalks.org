# frozen_string_literal: true

RSpec.describe EventRepository, type: :repository do
  let(:repo) { described_class.new }

  describe '.find_with_talks' do
    subject { repo.find_with_talks(id: event_id) }

    let(:event_id) { Fabricate(:event).id }

    context 'when event exists' do
      it 'returns event by id' do
        expect(subject.id).to eq(event_id)
      end
    end

    context 'when event exists' do
      let(:event_id) { -1 }

      it 'raises an error' do
        expect { subject }.to raise_error(ROM::TupleCountMismatchError)
      end
    end
  end
end
