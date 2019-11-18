# frozen_string_literal: true
# # frozen_string_literal: true

# RSpec.describe Web::Controllers::Speakers::Show do
#   subject { action.call(params) }

#   let(:action) { described_class.new(operation: operation) }

#   context 'when operation is success' do
#     let(:speaker) { Fabricate.build(:speaker, id: 1) }
#     let(:operation) { ->(*) { Success(speaker) } }
#     let(:params) { { id: speaker.id } }

#     it { expect(subject.first).to eq(200) }

#     it 'exposes speaker' do
#       subject
#       expect(action.speaker).to eq(speaker)
#     end
#   end

#   context 'when operation is not success' do
#     let(:params) { { id: -100 } }
#     let(:operation) { ->(*) { Failure() } }

#     it 'redirects to 404' do
#       expect(subject.first).to eq(404)
#     end
#   end

#   context 'with real data' do
#     let(:speaker) { Fabricate.create(:approved_speaker) }
#     let(:action) { described_class.new }
#     let(:params) { { id: speaker.id } }

#     it 'returns successfully response' do
#       subject
#       expect(subject.first).to eq(200)
#       expect(action.speaker.id).to eq(speaker.id)
#     end
#   end
# end
