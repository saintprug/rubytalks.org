# frozen_string_literal: true

RSpec.describe Speakers::Operations::Find, type: :operation do
  subject { described_class.new(speaker_repo: speaker_repo).call(id: 1) }

  context 'when object exists' do
    let(:speaker_repo) { instance_double('SpeakerRepository', find_with_talks: Fabricate.build(:speaker)) }

    it { is_expected.to be_success }
    it { expect(subject.value!).to be_instance_of(Speaker) }
  end

  context 'when object does not exist' do
    let(:speaker_repo) { instance_double('SpeakerRepository') }

    before { allow(speaker_repo).to receive(:find_with_talks).and_raise(ROM::TupleCountMismatchError) }

    it { is_expected.to be_failure }
  end
end
