# # frozen_string_literal: true

# RSpec.describe Web::Controllers::Events::Show do
#   subject { action.call(params) }

#   let(:action) { described_class.new(operation: operation) }

#   context 'when operation is success' do
#     let(:event) { Fabricate.build(:event, id: 1) }
#     let(:operation) { ->(*) { Success(event) } }
#     let(:params) { { id: event.id } }

#     it { expect(subject.first).to eq(200) }

#     it 'exposes event' do
#       subject
#       expect(action.event).to eq(event)
#     end
#   end

#   context 'when operation is not success' do
#     let(:params) { { id: -100 } }
#     let(:operation) { ->(*) { Failure(nil) } }

#     it 'redirects to 404' do
#       expect(subject.first).to eq(404)
#     end
#   end

#   context 'with real data' do
#     let(:event) { Fabricate.create(:approved_event) }
#     let(:action) { described_class.new }
#     let(:params) { { id: event.id } }

#     it 'returns successfully response' do
#       subject
#       expect(subject.first).to eq(200)
#       expect(action.event.id).to eq(event.id)
#     end
#   end
# end
