# frozen_string_literal: true

RSpec.describe SpeakerRepository, type: :repository do
  describe '#find_by_name' do
    subject { described_class.new.find_by_name(first_name: 'Alex', last_name: 'Koval') }

    let!(:speaker1) { Fabricate.create(:speaker, first_name: 'Alex', last_name: 'Koval') }
    let!(:speaker2) { Fabricate.create(:speaker, first_name: 'Alex', last_name: 'Korn') }
    let!(:speaker3) { Fabricate.create(:speaker, first_name: 'Jorge', last_name: 'Martin') }

    context 'when record exists' do
      it 'returns existing record' do
        expect(subject.first_name).to eq(speaker1.first_name)
      end
    end

    context 'when record does not exist' do
      subject { described_class.new.find_by_name(first_name: 'Steve', last_name: 'Voznyak') }

      it 'returns nil' do
        expect(subject).to be_nil
      end
    end
  end

  describe '#order_by_last_name' do
    subject { described_class.new.order_by_last_name }

    let!(:speaker1) { Fabricate.create(:speaker, first_name: 'Alex', last_name: 'Koval') }
    let!(:speaker2) { Fabricate.create(:speaker, first_name: 'Jorge', last_name: 'Martin') }
    let!(:speaker3) { Fabricate.create(:speaker, first_name: 'Bob', last_name: 'Martin') }
    let!(:speaker4) { Fabricate.create(:speaker, first_name: 'Cat', last_name: 'Simmons') }

    context 'without order param' do
      it 'returns speakers ordered by name asc' do
        expect(subject.map(&:first_name)).to eq([speaker1, speaker3, speaker2, speaker4].map(&:first_name))
      end
    end

    context 'with desc order param' do
      subject { described_class.new.order_by_last_name(order: :desc) }

      it 'returns speakers ordered by name desc' do
        expect(subject.map(&:first_name)).to eq([speaker4, speaker3, speaker2, speaker1].map(&:first_name))
      end
    end
  end

  describe '#find_with_talks' do
    subject { described_class.new.find_with_talks(id: approved_speaker_id) }

    let!(:unapproved_speakers) { Fabricate.times(5, :speaker) }
    let(:approved_speakers) { Fabricate.times(5, :approved_speaker) }
    let(:approved_speaker_id) { approved_speakers.last.id }

    it 'returns speaker by id' do
      expect(subject).to be_instance_of(Speaker)
      expect(subject.id).to eq(approved_speaker_id)
    end
  end

  describe '#all' do
    subject { described_class.new.all }

    let!(:unapproved_speakers) { Fabricate.times(5, :speaker) }
    let!(:approved_speakers) { Fabricate.times(6, :approved_speaker) }

    it 'returns all approved speakers' do
      expect(subject.length).to eq(6)
      expect(subject.map(&:id)).to match_array(approved_speakers.map(&:id))
    end
  end
end
