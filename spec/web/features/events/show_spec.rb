# frozen_string_literal: true

RSpec.describe 'GET /events/:id', type: :feature do
  let!(:event) { Fabricate.create(:event) }
  let(:url) { "/events/#{event.id}" }

  it 'returns event page' do
    visit(url)

    expect(page.status_code).to eq(200)
    expect(page).to have_content(event.name)
  end
end
