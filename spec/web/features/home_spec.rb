# frozen_string_literal: true

RSpec.describe 'GET /', type: :feature do
  let(:url) { '/' }

  it 'returns a home page' do
    visit(url)

    expect(page.status_code).to eq(200)
    expect(page).to have_selector(:link_or_button, 'Talks')
  end
end
