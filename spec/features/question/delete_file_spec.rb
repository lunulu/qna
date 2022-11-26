require 'rails_helper'

describe 'User can delete file attached to the question', "
  In order to delete unsuitable attachment in question
  As an author of the question
  I'd like to be able to delete file in my question
" do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, :with_files, user: author) }

  describe 'Authenticated user' do
    describe 'as an author' do
      before do
        sign_in(author)
        visit question_path(question)
      end

      it 'deletes file attached to the question' do
        click_on 'Delete file'
        expect(page).not_to have_content 'rails_helper.rb'
      end
    end

    describe 'as not an author' do
      before do
        sign_in(user)
        visit question_path(question)
      end

      it 'tries to delete file attached to the answer' do
        expect(page).not_to have_link 'Delete file'
      end
    end
  end
end
