require 'rails_helper'

describe 'User can delete link from question', "
  In order to delete wrong links from my question
  As an question's author
  I'd like to be able to delete links
" do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let!(:link) { create(:link, linkable: question) }

  it 'User deletes link from existing question', js: true do
    sign_in(user)
    visit edit_question_path(question)
    click_on 'Remove link'
    click_on 'Save'

    expect(page).not_to have_link link.name, href: link.url
  end
end
