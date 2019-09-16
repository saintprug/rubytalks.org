# frozen_string_literal: true

RSpec.describe 'GET /events', type: :feature do
  let!(:events) { Fabricate.times(3, :approved_event) }
  let(:url) { '/events' }

  it 'returns events page' do
    visit(url)

    expect(page.status_code).to eq(200)
    expect(page).to have_content(events[0].name)
    expect(page).to have_content(events[1].name)
    expect(page).to have_content(events[2].name)
  end
end
