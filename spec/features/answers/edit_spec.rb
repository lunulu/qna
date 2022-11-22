require 'rails_helper'

describe 'User can edit his answer', "
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
" do
  let!(:user) { create(:user) }
  let!(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question, user: user) }

  it 'Unauthenticated user can not edit answer' do
    visit question_path(question)
    expect(page).not_to have_link 'Edit'
  end

  describe 'Authenticated user' do
    it 'edits his answer', js: true do
      sign_in(user)
      visit question_path(question)
      click_on 'Edit'

      within '.answers' do
        fill_in 'Your answer', with: 'edited answer'
        click_on 'Save'

        expect(page).not_to have_content answer.body
        expect(page).to have_content 'edited answer'
        # TODO: fix text
        # expect(page).not_to have_selector 'textarea'
      end
    end

    it 'edits his answer with errors'

    it "tries to edit other user's answer"
  end
end
