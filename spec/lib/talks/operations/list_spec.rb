# frozen_string_literal: true

RSpec.describe Talks::Operations::List do
  subject { operation.call({}) }

  let(:operation) { described_class.new(talk_repo: talk_repo) }
  let(:talk_repo) { instance_double('TalksRepository', latest: Fabricate.build_times(3, :talk)) }

  context 'when talks exist' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.length).to eq(3) }
  end

  context 'when there are no talks' do
    let(:talk_repo) { instance_double('TalksRepository', latest: []) }

    it { expect(subject).to be_success }
    it { expect(subject.value!.length).to eq(0) }
  end

  context 'with real data' do
    let!(:talks) { Fabricate.times(3, :approved_talk) }
    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(Array) }
    it { expect(subject.value!.map(&:id)).to include(*talks.map(&:id)) }
  end
end
