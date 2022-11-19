require 'rails_helper'

describe 'User can sign up', "
  In order to ask questions
  As an unregistered user
  I'd like to be able to sign up
" do
  before { visit new_user_registration_path }

  it 'Unregistered user tries to sign up' do
    fill_in 'Email', with: 'example@test.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content 'You have signed up successfully.'
  end

  it 'Unregistered user tries to sign up with errors' do
    click_on 'Sign up'

    expect(page).to have_content "Email can't be blank"
  end
end
