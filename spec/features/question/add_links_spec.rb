require 'rails_helper'

describe 'User can add links to question', "
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
" do
  let(:user) { create(:user) }
  let(:url) { 'https://vk.com' }

  describe 'User' do
    before do
      sign_in(user)
      visit new_question_path
    end

    it 'adds link when asks question', js: true do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      click_on 'Add link'
      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with: url
      click_on 'Save'

      expect(page).to have_link 'My gist', href: url
    end
  end
end
