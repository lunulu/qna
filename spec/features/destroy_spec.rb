require 'rails_helper'

describe 'User can delete his question or answer', "
  In order to delete question or answer
  As an author of the question or the answer
  I'd like to be able to delete the question or the answer
" do
  let(:author) { create(:user) }
  let(:question) { create(:question, user: author) }

  before { create(:answer, question: question, user: author) }

  describe 'User as an author' do
    before do
      sign_in(author)
      visit question_path(question)
    end

    it 'tries to delete the question' do
      click_on 'Delete your question'

      expect(page).to have_content 'Your question was successfully deleted.'
    end

    it 'tries to delete the answer' do
      click_on 'Delete your answer'

      expect(page).to have_content 'Your answer was successfully deleted.'
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

    it 'tries to delete the answer' do
      expect(page).to have_no_content 'Delete your answer'
    end
  end
end
