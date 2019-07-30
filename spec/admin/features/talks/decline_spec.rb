# frozen_string_literal: true

RSpec.describe 'PATCH /admin/talks/:id/decline', type: :feature do
  let(:url) { '/admin' }

  let!(:talk) { Fabricate.create(:talk_with_speaker_and_event) }

  it 'returns /admin page without selected talk' do
    visit(url)

    click_button('Decline')

    expect(page.status_code).to eq(200)
    expect(page).not_to have_content(talk.title)
  end
end
