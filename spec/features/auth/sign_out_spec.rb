require 'rails_helper'

describe 'Authenticated user can sign out', "
  In order to end session
  As an authenticated user
  I'd like to be able to sign out
" do
  let(:user) { create(:user) }

  before { sign_in(user) }

  it 'Authenticated user tries to sign out' do
    visit root_path
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end
end
