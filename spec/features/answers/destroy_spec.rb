require 'rails_helper'

describe 'User can delete his answer', "
  In order to delete answer
  As an author of the answer
  I'd like to be able to delete the answer
" do
  let(:author) { create(:user) }
  let(:question) { create(:question, user: author) }
  let!(:answer) { create(:answer, question: question, user: author) }

  describe 'User as an author' do
    before do
      sign_in(author)
      visit question_path(question)
    end

    it 'deletes the answer', js: true do
      click_on 'Delete your answer'
      expect(page).not_to have_content answer.body
    end
  end

  describe 'User as not an author' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      visit question_path(question)
    end

    it 'tries to delete the answer' do
      expect(page).to have_no_content 'Delete your answer'
    end
  end
end
