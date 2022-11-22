require 'rails_helper'

describe 'User can answer the question', "
  In order to answer a question from community
  As an authenticated user
  I'd like to be able to write my answer on question's page
" do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe 'Authenticated user', js: true do
    before do
      sign_in(user)
      visit question_path(question)
    end

    it 'answers the question' do
      fill_in 'Body', with: 'text text text'
      click_on 'Post your answer'

      expect(page).to have_current_path question_path(question), ignore_query: true
      within '.answers' do
        expect(page).to have_content 'text text text'
      end
    end

    it 'answers the question with errors' do
      click_on 'Post your answer'
      expect(page).to have_content "Body can't be blank"
    end
  end

  it 'Unauthenticated user tries to answer the question' do
    visit question_path(question)
    click_on 'Post your answer'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
