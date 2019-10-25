# frozen_string_literal: true

RSpec.describe Domains::Talks::Operations::List do
  subject { described_class.new(talk_repo: talk_repo) }

  let(:talk_repo) { instance_double(Repositories::Talk, all: 3.times.map { Factory.structs[:talk] }) }

  context 'talks exist' do
    it { expect(subject.call).to be_success }
    it { expect(subject.call.value!).to be_a(Array) }
    it { expect(subject.call.value!.length).to eq(3) }
  end

  context 'there are no talks' do
    let(:talk_repo) { instance_double(Repositories::Talk, all: []) }

    it { expect(subject.call).to be_success }
    it { expect(subject.call.value!.length).to eq(0) }
  end
end
