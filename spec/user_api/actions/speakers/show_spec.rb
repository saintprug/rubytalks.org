# frozen_string_literal: true

RSpec.describe UserApi::Actions::Speakers::Show do
  subject { action.call(params) }

  let(:action) { described_class.new(configuration: Hanami::Controller::Configuration.new, find_approved: operation) }

  context 'when operation is success' do
    let(:speaker) { Factory.structs[:speaker] }
    let(:operation) { ->(*) { Success(speaker) } }
    let(:params) { { id: speaker.id } }

    it { expect(subject.status).to eq(200) }
  end

  context 'when operation is failure' do
    let(:params) { { id: -100 } }
    let(:operation) { ->(*) { Failure(ROM::TupleCountMismatchError) } }

    it 'redirects to 404' do
      expect(subject.status).to eq(404)
    end
  end
end
