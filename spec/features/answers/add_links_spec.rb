require 'rails_helper'

describe 'User can add links to answer', "
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
" do
  let(:user) { create(:user) }
  let(:gist_url) { 'https://gist.github.com/lunulu/142d82aaa6647f3ec5adab8e00aa0bf6' }
  let(:question) { create(:question) }

  it 'User adds link when asks answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'text text text'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Post your answer'

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end
  end
end
