require 'rails_helper'

describe 'User can delete his question', "
  In order to delete question
  As an author of the question
  I'd like to be able to delete the question
" do
  let(:author) { create(:user) }
  let(:question) { create(:question, user: author) }

  describe 'User as an author' do
    before do
      sign_in(author)
      visit question_path(question)
    end

    it 'deletes the question' do
      click_on 'Delete your question'

      expect(page).to have_content 'Your question was successfully deleted.'
    end
  end

  describe 'User as not an author' do
    let(:user) { create(:user) }

    before do
      sign_in(user)
      visit question_path(question)
    end

    it 'tries to delete the question' do
      expect(page).to have_no_content 'Delete your question'
    end
  end
end
