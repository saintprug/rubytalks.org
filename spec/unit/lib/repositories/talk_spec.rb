# frozen_string_literal: true

RSpec.describe Repositories::Talk do
  subject { described_class.new(Hanami::Container[:rom]) }

  let!(:approved_talks) do
    12.times.map { Factory[:approved_talk] }
  end

  let!(:unpublished_talks) do
    3.times.map { Factory[:talk] }
  end

  let!(:declined_talks) do
    5.times.map { Factory[:declined_talk] }
  end

  describe '#find_unapproved' do
    let(:unapproved_talk_id) { unpublished_talks.last.id }

    it 'returns unapproved talk' do
      result = subject.find_unapproved(unapproved_talk_id)

      expect(result.id).to eq(unapproved_talk_id)
    end
  end

  describe '#find_approved_with_speakers_and_event' do
    subject { described_class.new.find_approved_with_speakers_and_event(approved_talk_id) }

    let(:approved_talk_id) { approved_talks.last.id }

    it 'returns approved talk' do
      expect(subject.id).to eq(approved_talk_id)
    end
  end
end
