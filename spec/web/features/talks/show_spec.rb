# frozen_string_literal: true

RSpec.describe 'GET /talks/:id', type: :feature do
  let!(:talk) { Fabricate.create(:approved_talk) }
  let(:url) { "/talks/#{talk.id}" }

  it 'returns talk page' do
    visit(url)

    expect(page.status_code).to eq(200)
    expect(page).to have_content(talk.title)
  end
end
