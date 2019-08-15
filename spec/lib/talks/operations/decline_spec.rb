# frozen_string_literal: true

RSpec.describe Talks::Operations::Decline do
  subject { operation.call(id) }

  describe 'with mocks' do
    let(:operation) { described_class.new(talk_repo: talk_repo, speaker_repo: speaker_repo, event_repo: event_repo) }
    let(:talk) { Talk.new(id: 1, speakers: [Speaker.new(id: 1), Speaker.new(id: 2)], event_id: 1) }
    let(:talk_repo) { instance_double('TalkRepository', transaction: nil, find_with_speakers_and_event: talk, update: true) }
    let(:speaker_repo) { instance_double('SpeakerRepository', update: true) }
    let(:event_repo) { instance_double('EventRepository', update: true) }
    let(:id) { 1 }

    context 'when every repo returns success value' do
      it 'returns success' do
        expect(subject).to be_success
      end
    end

    context 'when talk is not found' do
      before do
        allow(talk_repo).to receive(:find_with_speakers_and_event).and_raise(ROM::TupleCountMismatchError)
      end

      it 'returns failure' do
        expect(subject).to be_failure
      end
    end
  end

  describe 'with real data' do
    let(:id) { Fabricate.create(:talk_with_speaker_and_event).id }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it 'creates all the entities' do
      subject
      expect(TalkRepository.new.find(id).state).to eq('declined')
      expect(TalkRepository.new.root.combine(:speakers).by_pk(id).speakers.map { |s| s[:state] }).to eq(['declined'])
      expect(TalkRepository.new.root.combine(:event).by_pk(id).one.event.state).to eq('declined')
    end
  end
end

