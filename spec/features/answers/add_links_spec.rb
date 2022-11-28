require 'rails_helper'

describe 'User can add links to answer', "
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
" do
  let(:user) { create(:user) }
  let(:url) { 'https://vk.com' }
  let(:question) { create(:question, user: user) }

  describe 'User' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    it 'adds link when asks answer', js: true do
      fill_in 'Body', with: 'text text text'

      click_on 'Add link'
      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with: url

      click_on 'Post your answer'

      within '.answers' do
        expect(page).to have_link 'My gist', href: url
      end
    end
  end
end
