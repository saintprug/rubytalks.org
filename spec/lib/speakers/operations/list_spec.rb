# frozen_string_literal: true

RSpec.describe Speakers::Operations::List do
  subject { operation.call({}) }

  let(:operation) { described_class.new(speaker_repo: speaker_repo) }
  let(:speaker_repo) { instance_double('SpeakerRepository', all: Fabricate.build_times(3, :speaker)) }

  context 'when speakers exist' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.length).to eq(3) }
  end

  context 'when there are no speakers' do
    let(:speaker_repo) { instance_double('SpeakerRepository', all: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.length).to eq(0) }
  end

  context 'with real data' do
    let!(:speakers) { Fabricate.times(3, :approved_speaker) }
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.map(&:id)).to include(*speakers.map(&:id)) }
  end
end
