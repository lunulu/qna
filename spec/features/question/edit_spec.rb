require 'rails_helper'

describe 'User can edit question', "
  In order to edit question
  As an authenticated user
  I'd like to be able to edit the question
" do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  describe 'Authenticated user' do
    before do
      sign_in(user)

      visit question_path(question)
      click_on 'Edit question'
    end

    it 'edits the question' do
      fill_in 'Title', with: 'edited title'
      fill_in 'Body', with: 'edited body'
      click_on 'Save'

      expect(page).to have_content 'Your question successfully updated.'
      expect(page).to have_content 'edited title'
      expect(page).to have_content 'edited body'
    end

    it 'edits the question by attaching files' do
      attach_file 'File', [Rails.root.join('spec/rails_helper.rb'), Rails.root.join('spec/spec_helper.rb')]
      click_on 'Save'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    it 'edits the question with errors' do
      fill_in 'Title', with: ''
      click_on 'Save'

      expect(page).to have_content "Title can't be blank"
    end
  end

  it 'Unauthenticated user tries to ask a question' do
    visit question_path(question)

    expect(page).not_to have_link 'Edit question'
  end
end
