require 'rails_helper'

describe 'Author of question can mark best question', "
  In order to mark best answer
  As an author of question
  I'd like to be able to mark best answer on my question's page
" do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, user: author) }
  let!(:answers) { create_list(:answer, 2, question: question, user: user) }

  before { answers[0].mark_as_best }

  describe 'User' do
    describe 'as an author of question' do
      before do
        sign_in(author)
        visit question_path(question)
      end

      it 'marks answer as best' do
        click_on 'Mark as best'

        within '.best' do
          expect(page).not_to have_content answers[0].body
          expect(page).to have_content answers[1].body
        end
      end
    end

    describe 'as not an author of question' do
      it 'tries to mark the answer as best' do
        sign_in(user)
        visit question_path(question)
        expect(page).not_to have_link 'Mark as best'
      end
    end
  end
end
