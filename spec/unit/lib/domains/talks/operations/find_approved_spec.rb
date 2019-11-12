# frozen_string_literal: true

RSpec.describe Domains::Talks::Operations::FindApproved do
  subject { operation.call(id: 1) }

  let(:operation) { described_class.new(talk_repo: talk_repo) }
  let(:talk_repo) { instance_double(Repositories::Talk, find_approved_with_speakers_and_event: Factory.structs[:talk]) }

  context 'talk exists' do
    it { expect(subject).to be_success }
    it { expect(subject.value!).to be_a(ROM::Struct::Talk) }
  end

  context 'talk does not exist' do
    let(:talk_repo) { instance_double(Repositories::Talk) }

    before do
      allow(talk_repo).to receive(:find_approved_with_speakers_and_event).and_raise(ROM::TupleCountMismatchError)
    end

    it { expect(subject).to be_failure }
  end
end
