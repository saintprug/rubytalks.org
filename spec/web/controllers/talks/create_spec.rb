# frozen_string_literal: true

RSpec.describe Web::Controllers::Talks::Create do
  subject { action.call(params) }

  let(:flash) { action.exposures[:flash] }

  context 'with mocks' do
    let(:action) { described_class.new(operation: operation, form: form) }
    let(:form) { instance_double('Web::Forms::TalkForm') }

    before { allow(form).to receive(:call).and_return(OpenStruct.new(success?: true)) }

    context 'when operation is success' do
      let(:operation) { ->(*) { Success() } }
      let(:params) { {} }

      it 'redirects to talks page' do
        expect(subject.first).to eq(302)
        expect(flash[:success]).to eq('Talk has been created. It will appear in the '\
                                      'list when Administrator approves it')
      end
    end

    context 'when operation is not success' do
      let(:params) { {} }
      let(:operation) { ->(*) { Failure() } }

      it 'redirects to talks page' do
        expect(subject.first).to eq(302)
        expect(flash[:error]).to eq('Something wrong')
      end
    end
  end

  context 'with real data' do
    let(:talk_params) { Fabricate.attributes_for(:talk) }
    let(:speaker_params) { Fabricate.attributes_for(:speaker) }
    let(:event_params) { Fabricate.attributes_for(:event) }

    let(:action) { described_class.new }
    let(:params) { { talk: talk_params.merge(speakers: [speaker_params], event: event_params) } }

    it 'redirects to created talk' do
      subject
      expect(subject.first).to eq(302)
      expect(flash[:success]).to eq('Talk has been created. It will appear in the list when Administrator approves it')
    end
  end
end
