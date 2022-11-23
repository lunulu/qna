require 'rails_helper'

describe 'User can edit his answer', "
  In order to correct mistakes
  As an author of answer
  I'd like to be able to edit my answer
" do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:question) { create(:question) }
  let!(:answer) { create(:answer, question: question, user: user) }

  it 'Unauthenticated user can not edit answer' do
    visit question_path(question)
    expect(page).not_to have_link 'Edit'
  end

  describe 'Authenticated user' do
    describe 'as author' do
      before do
        sign_in(user)
        visit question_path(question)
        click_on 'Edit'
      end

      it 'edits his answer', js: true do
        within '.answers' do
          fill_in 'Your answer', with: 'edited answer'
          click_on 'Save'


          expect(page).not_to have_content answer.body
          expect(page).to have_content 'edited answer'
          expect(page).to have_css '.hidden'
        end
      end

      it 'edits his answer with errors', js: true do
        within '.answers' do
          fill_in 'Your answer', with: ''
          click_on 'Save'
        end

        expect(page).to have_content "Body can't be blank"
      end
    end

    it "tries to edit other user's answer" do
      sign_in(other_user)
      visit question_path(question)
      expect(page).not_to have_link 'Edit'
    end
  end
end
