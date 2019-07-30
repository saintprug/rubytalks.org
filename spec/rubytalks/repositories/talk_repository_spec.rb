# frozen_string_literal: true

RSpec.describe TalkRepository, type: :repository do
  let!(:approved_talks) { Fabricate.times(12, :approved_talk) }
  let!(:unpublished_talks) { Fabricate.times(3, :talk) }
  let!(:declined_talks) { Fabricate.times(5, :declined_talk) }

  describe '#latest' do
    subject { described_class.new.latest }

    context 'without limit' do
      it 'returns 10 or less approved talks ordered by :talked_at' do
        expect(subject.length).to eq(10)
        expect(subject.map(&:state).uniq).to eq(['approved'])
        expect(subject.map(&:id)).to eq(approved_talks.sort_by { |talk| -talk.talked_at.to_i }.map(&:id).first(10))
      end
    end
  end

  describe '#for_approve' do
    subject { described_class.new.for_approve }

    context 'without limit' do
      it 'returns 10 or less unpublished talks ordered by :created_at' do
        expect(subject.length).to eq(3)
        expect(subject.map(&:state).uniq).to eq(['unpublished'])
        expect(subject.map(&:id)).to eq(unpublished_talks.sort_by { |talk| -talk.created_at.to_i }.map(&:id))
      end
    end
  end

  describe '#find_unapproved' do
    subject { described_class.new.find_unapproved(unapproved_talk_id) }

    let(:unapproved_talk_id) { unpublished_talks.last.id }

    it 'returns unapproved talk' do
      expect(subject.id).to eq(unapproved_talk_id)
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
