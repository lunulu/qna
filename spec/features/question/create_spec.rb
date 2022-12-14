require 'rails_helper'

describe 'User can create question', "
  In order to get answer from community
  As an authenticated user
  I'd like to be able to ask the question
" do
  let(:user) { create(:user) }

  describe 'Authenticated user' do
    before do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end

    it 'asks a question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      click_on 'Save'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'text text text'
    end

    it 'asks a question with errors' do
      click_on 'Save'

      expect(page).to have_content "Title can't be blank"
    end

    it 'asks a question with attached files' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'
      attach_file 'File', [Rails.root.join('spec/rails_helper.rb'), Rails.root.join('spec/spec_helper.rb')]
      click_on 'Save'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end

    it 'asks a question with reward' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'text text text'

      within '.reward' do
        fill_in 'Reward title', with: 'Reward name'
        attach_file 'Image', Rails.root.join('app/assets/images/thinknetica.png')
      end

      click_on 'Save'

      expect(page).to have_content 'Reward name'
    end
  end

  it 'Unauthenticated user tries to ask a question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
