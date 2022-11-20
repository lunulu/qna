require 'rails_helper'

RSpec.describe AnswersController do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) } }.to change(Answer, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer).merge(user_id: user.id) }

        expect(response).to redirect_to question
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) } }.not_to change(Answer, :count)
      end

      it 're-renders new view' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let!(:answer) { create(:answer, question: question, user: user) }

    it 'deletes the answer' do
      expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'redirects to question show view' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to question_path(question)
    end
  end
end
