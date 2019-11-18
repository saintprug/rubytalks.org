# frozen_string_literal: true

RSpec.describe 'AdminApi: Events', type: :request do
  describe 'PATCH /admin_api/events/:id' do
    context 'valid params' do
      let(:name) { 'Whatever' }
      let(:event) do
        Hanami::Container['repositories.event'].create(Factory.structs[:event])
      end

      let(:params) do
        {
          name: name
        }
      end

      it 'returns 200' do
        patch "/admin/events/#{event.id}", body: params.to_json, headers: default_headers

        expect(response_status).to eq 200
        expect(response_data).to match_json_schema('admin_api/event')
        expect(response_data['name']).to eq name
      end
    end
  end
end
