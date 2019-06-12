# frozen_string_literal: true

RSpec.describe 'GET /speakers', type: :feature do
  let!(:speakers) { Fabricate.times(3, :speaker) }
  let(:url) { '/speakers' }

  it 'returns speakers page' do
    visit(url)

    expect(page.status_code).to eq(200)
    expect(page).to have_content(speakers[0].full_name)
    expect(page).to have_content(speakers[1].full_name)
    expect(page).to have_content(speakers[2].full_name)
  end
end
