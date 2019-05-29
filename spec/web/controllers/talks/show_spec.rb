# frozen_string_literal: true

RSpec.describe Web::Controllers::Talks::Show do
  subject { action.call(params) }

  let(:action) { described_class.new(operation: operation) }

  context 'when operation is success' do
    let(:talk) { Talk.new(id: 1) }
    let(:operation) { ->(*) { Success(talk) } }
    let(:params) { { id: talk.id } }

    it { expect(subject.first).to eq(200) }

    it 'exposes talk' do
      subject
      expect(action.talk).to eq(talk)
    end
  end

  context 'when operation is not success' do
    let(:params) { { id: -100 } }
    let(:operation) { ->(*) { Failure(nil) } }

    it 'redirects to 404' do
      expect(subject.first).to eq(404)
    end
  end

  context 'with real data' do
    let(:talk) { Fabricate.create(:talk) }
    let(:action) { described_class.new }
    let(:params) { { id: talk.id } }

    it 'returns successfully response' do
      subject
      expect(subject.first).to eq(200)
      expect(action.talk[:id]).to eq(talk.id)
    end
  end
end
