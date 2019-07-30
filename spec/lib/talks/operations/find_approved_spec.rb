# frozen_string_literal: true

RSpec.describe Talks::Operations::FindApproved do
  subject { operation.call(id: 1) }

  let(:operation) { described_class.new(talk_repo: talk_repo) }
  let(:talk_repo) { instance_double('TalkRepository', find_approved_with_speakers_and_event: Talk.new) }

  context 'when talk exists' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Talk) }
  end

  context 'when talk does not exist' do
    let(:talk_repo) { instance_double('TalkRepository') }

    before do
      allow(talk_repo).to receive(:find_approved_with_speakers_and_event).and_raise(ROM::TupleCountMismatchError)
    end

    it { expect(subject).to be_failure }
  end

  context 'with real data' do
    subject { operation.call(id: talk.id) }

    let(:talk) { Fabricate.create(:approved_talk) }
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Talk) }
  end
end
