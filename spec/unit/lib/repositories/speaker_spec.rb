# frozen_string_literal: true

RSpec.describe Repositories::Speaker do
  subject { described_class.new(Hanami::Container[:rom]) }

  describe '#find_by_name' do
    let!(:speaker1) { subject.create(Factory.structs[:speaker].attributes.merge(first_name: 'Alex', last_name: 'Koval')) }
    let!(:speaker2) { subject.create(Factory.structs[:speaker].attributes.merge(first_name: 'Alex', last_name: 'Korn')) }
    let!(:speaker3) { subject.create(Factory.structs[:speaker].attributes.merge(first_name: 'Jorge', last_name: 'Martin')) }

    context 'when record exists' do
      it 'returns existing record' do
        result = subject.find_by_name(first_name: 'Alex', last_name: 'Koval')

        expect(result.first_name).to eq(speaker1.first_name)
      end
    end

    context 'when record does not exist' do
      it 'returns nil' do
        result = subject.find_by_name(first_name: 'Steve', last_name: 'Voznyak')

        expect(result).to be_nil
      end
    end
  end

  describe '#order_by_last_name' do
    let!(:speaker1) { subject.create(Factory.structs[:speaker].attributes.merge(first_name: 'Alex', last_name: 'Koval')) }
    let!(:speaker2) { subject.create(Factory.structs[:speaker].attributes.merge(first_name: 'Jorge', last_name: 'Martin')) }
    let!(:speaker3) { subject.create(Factory.structs[:speaker].attributes.merge(first_name: 'Bob', last_name: 'Martin')) }
    let!(:speaker4) { subject.create(Factory.structs[:speaker].attributes.merge(first_name: 'Cat', last_name: 'Simmons')) }

    context 'without order param' do
      it 'returns speakers ordered by name asc' do
        result = subject.order_by_last_name

        expect(result.map(&:first_name)).to eq([speaker1, speaker3, speaker2, speaker4].map(&:first_name))
      end
    end

    context 'with desc order param' do
      it 'returns speakers ordered by name desc' do
        result = subject.order_by_last_name(order: :desc)

        expect(result.map(&:first_name)).to eq([speaker4, speaker3, speaker2, speaker1].map(&:first_name))
      end
    end
  end

  describe '#find_with_talks' do
    let!(:unapproved_speakers) do
      5.times.map { Factory[:speaker] }
    end

    let(:approved_speakers) do
      5.times.map { Factory[:approved_speaker] }
    end
                                                                      
    let(:approved_speaker_id) { approved_speakers.last.id }

    it 'returns speaker by id' do
      result = subject.find_with_talks(id: approved_speaker_id)

      expect(result).to be_kind_of(ROM::Struct::Speaker)
      expect(result.id).to eq(approved_speaker_id)
    end
  end

  describe '#all' do
    let!(:unapproved_speakers) do
      5.times.map { Factory[:speaker] }
    end

    let!(:approved_speakers) do
      6.times.map { Factory[:approved_speaker] }
    end

    it 'returns all approved speakers' do
      result = subject.all

      expect(result.length).to eq(6)
      expect(result.map(&:id)).to match_array(approved_speakers.map(&:id))
    end
  end
end
