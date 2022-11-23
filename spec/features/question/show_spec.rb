require 'rails_helper'

describe "User can view question's answers", "
  In order to observer resolving the question
  As a user
  I'd like to be able to view answers on question's page
" do
  let(:question) { create(:question) }
  let!(:answers) { create_list(:answer, 3, question: question) }

  describe 'User' do
    before { visit question_path(question) }

    it "views question's answers" do
      expect(page).to have_content question.title
      expect(page).to have_content question.body

      answers.each do |answer|
        expect(page).to have_content answer.body
      end
    end
  end
end
