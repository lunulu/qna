require 'rails_helper'

describe 'User can answer the question', "
  In order to answer a question from community
  As an authenticated user
  I'd like to be able to write my answer on question's page
" do
  let(:user) { create(:user) }
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

  describe 'Authenticated user' do
    before do
      sign_in(user)

      visit question_path(question)
    end

    it 'answers the question' do
      fill_in 'Body', with: 'text text text'
      click_on 'Post your answer'

      expect(page).to have_content 'Your answer successfully posted.'
      expect(page).to have_content 'text text text'
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
