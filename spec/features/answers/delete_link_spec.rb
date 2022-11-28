require 'rails_helper'

describe 'User can delete link from answer', "
  In order to delete wrong links from my answer
  As an answer's author
  I'd like to be able to delete link
" do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question, user: user) }
  let!(:link) { create(:link, linkable: answer) }

  it 'User deletes link from existing question', js: true do
    sign_in(user)
    visit question_path(question)
    click_on 'Edit'
    click_on 'Remove link'
    click_on 'Save'

    expect(page).not_to have_link link.name, href: link.url
  end
end
