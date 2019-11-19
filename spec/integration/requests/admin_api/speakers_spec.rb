# frozen_string_literal: true

RSpec.describe 'AdminApi: Speakers', type: :request do
  describe 'PATCH /admin_api/speakers/:id' do
    context 'valid params' do
      let(:first_name) { 'Whatever' }
      let(:speaker) do
        Hanami::Container['repositories.speaker'].create(Factory.structs[:speaker])
      end

      let(:params) do
        {
          first_name: first_name
        }
      end

      it 'returns 200' do
        patch "/admin/speakers/#{speaker.id}", body: params.to_json, headers: default_headers

        expect(response_status).to eq 200
        expect(response_data).to match_json_schema('admin_api/speaker')
        expect(response_data['first_name']).to eq first_name
      end
    end
  end
end
