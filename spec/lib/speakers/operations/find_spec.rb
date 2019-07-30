# frozen_string_literal: true

RSpec.describe Speakers::Operations::Find do
  subject { operation.call(id: 1) }

  let(:operation) { described_class.new(speaker_repo: speaker_repo) }
  let(:speaker_repo) { instance_double('SpeakerRepository', find_with_talks: Speaker.new) }

  context 'when speaker exists' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Speaker) }
  end

  context 'when speaker does not exist' do
    let(:speaker_repo) { instance_double('SpeakerRepository') }

    before { allow(speaker_repo).to receive(:find_with_talks).and_raise(ROM::TupleCountMismatchError) }

    it { expect(subject).to be_failure }
  end

  context 'with real data' do
    subject { operation.call(id: speaker.id) }

    let(:speaker) { Fabricate.create(:approved_speaker) }
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Speaker) }
  end
end
