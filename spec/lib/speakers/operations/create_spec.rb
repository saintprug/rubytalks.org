# frozen_string_literal: true

RSpec.describe Speakers::Operations::Create do
  subject { operation.call(speaker_form) }

  let(:operation) { described_class.new(speaker_repo: speaker_repo) }
  let(:speaker_repo) { instance_double('SpeakerRepository', create: Speaker.new) }
  let(:speaker_form) { Fabricate.attributes_for(:speaker) }

  context 'when speaker form is valid' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Speaker) }
  end

  context 'when speaker has not created' do
    let(:speaker_repo) { instance_double('SpeakerRepository', create: nil) }

    it { expect(subject).to be_failure }
  end

  context 'with real data' do
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Speaker) }
    it { expect { subject }.to change { SpeakerRepository.new.root.where(state: 'unpublished').count }.by(1) }
  end
end
