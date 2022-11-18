require 'rails_helper'

describe 'User can view the list of questions', "
  In order to see actual questions from community
  As a user
  I'd like to be able to view all existing questions
" do
  let!(:questions) { create_list(:question, 3, :numbered) }

  it 'User views list of all questions' do
    visit questions_path

    expect(page).to have_content questions[0].title
    expect(page).to have_content questions[1].title
    expect(page).to have_content questions[2].title
  end
end
