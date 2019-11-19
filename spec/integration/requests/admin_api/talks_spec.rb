# frozen_string_literal: true

RSpec.describe 'AdminApi: Talks', type: :request do
  describe 'GET /admin_api/talks/unpublished' do
    context 'valid params' do
      before do
        talk = Factory.structs[:unpublished_talk]
        Hanami::Container['repositories.talk'].create(talk)
      end

      it 'returns 200' do
        get '/admin/talks/unpublished', headers: default_headers

        expect(response_status).to eq 200
        expect(response_data.size).to be > 0
        expect(response_data).to match_json_schema('admin_api/talks')
      end
    end
  end

  describe 'POST /admin_api/talks/:id/approve' do
    context 'valid params' do
      let(:talk) do
        talk = Factory.structs[:unpublished_talk]
        Hanami::Container['repositories.talk'].create(talk)
      end

      it 'returns 200' do
        post "/admin/talks/#{talk.id}/approve", headers: default_headers

        expect(response_status).to eq 200
        expect(response_data).to match_json_schema('admin_api/talk')
      end
    end
  end

  describe 'POST /admin_api/talks/:id/decline' do
    context 'valid params' do
      let(:talk) do
        talk = Factory.structs[:approved_talk]
        Hanami::Container['repositories.talk'].create(talk)
      end

      it 'returns 200' do
        post "/admin/talks/#{talk.id}/decline"

        expect(response_status).to eq 200
        expect(response_data).to match_json_schema('admin_api/talk')
      end
    end
  end

  describe 'PATCH /admin_api/talks/:id' do
    context 'valid params' do
      let(:new_title) { 'new title' }
      let(:talk) do
        talk = Factory.structs[:approved_talk]
        Hanami::Container['repositories.talk'].create(talk)
      end

      let(:params) do
        {
          title: new_title
        }
      end

      it 'returns 200' do
        patch "/admin/talks/#{talk.id}", body: params.to_json, headers: default_headers

        expect(response_status).to eq 200
        expect(response_data).to match_json_schema('admin_api/talk')
        expect(response_data['title']).to eq new_title
      end
    end
  end
end
