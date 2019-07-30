# frozen_string_literal: true

RSpec.describe Talks::Operations::Create do
  subject { operation.call(talk_form) }

  let(:oembed) { class_double('OEmbed::Providers') }

  let(:talk_form) do
    Fabricate.attributes_for(:talk).merge(
      speakers: [Fabricate.attributes_for(:speaker)],
      event: Fabricate.attributes_for(:event),
      talk: Fabricate.attributes_for(:talk)
    )
  end

  context 'with real data' do
    before do
      allow(oembed).to receive(:get).and_return(OpenStruct.new(html: '<iframe width="100%" height="300px" src="https://www.youtube.com/embed/0nc3SXoObs8" frameborder="0" allowfullscreen></iframe>')) # rubocop: disable Metrics/LineLength
    end

    let(:operation) { described_class.new(oembed: oembed) }

    it { expect(subject).to be_success }
    it 'creates all the entities' do
      expect { subject }.to change {
        TalkRepository.new.all.count
        EventRepository.new.all.count
        SpeakerRepository.new.all.count
        TalksSpeakersRepository.new.all.count
      }.by(1)
    end
  end
end
