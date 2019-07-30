# frozen_string_literal: true

RSpec.describe 'POST /talks', type: :feature do
  let(:url) { '/talks/new' }

  context 'when all fields are filled' do
    it 'successfully creates a new talk' do
      visit(url)

      fill_in 'Title', with: 'Why you should use Rubytalks?'
      fill_in 'Description', with: 'Short description about conferences and community'
      fill_in 'Date of talk', with: '01/01/2019'
      fill_in 'Link from Youtube, Vimeo, etc.', with: 'https://www.youtube.com/watch?v=t99KH0TR-J4'

      fill_in 'Speaker first name', with: 'Alex'
      fill_in 'Speaker last name', with: 'Koval'
      fill_in 'Event title', with: 'Saint P Ruby Conf'
      fill_in 'Event city', with: 'Saint Petersburg'
      fill_in 'Event started at', with: '06/01/2019'
      fill_in 'Event ended at', with: '06/02/2019'

      click_button('Create talk')

      expect(page.status_code).to eq(200)
      expect(page).to have_content('Talk has been created. It will appear in the list when Administrator approves it')
    end
  end
end
