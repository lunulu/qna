require 'rails_helper'

RSpec.describe AnswersController do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  before { login(user) }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer) }, format: :js }.to change(Answer, :count).by(1)
      end

      it 'renders create template' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer).merge(user_id: user.id) }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect { post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }, format: :js }.not_to change(Answer, :count)
      end

      it 'renders create template' do
        post :create, params: { question_id: question.id, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    let!(:answer) { create(:answer, question: question, user: user) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.not_to change(answer, :body)
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:answer) { create(:answer, question: question, user: user) }

    it 'deletes the answer' do
      expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
    end

    it 'renders destroy view' do
      delete :destroy, params: { id: answer }, format: :js
      expect(response).to render_template :destroy
    end
  end

  describe 'POST #mark_as_best' do
    let(:question_with_reward) { create(:question, :with_reward) }
    let(:answer) { create(:answer, question: question, user: user) }

    before { answer.mark_as_best }

    it 'marks the answer as best' do
      post :mark_as_best, params: { id: answer }
      expect(question.best_answer).to eq answer
    end

    it "redirects to answer's question show view" do
      post :mark_as_best, params: { id: answer }
      expect(response).to redirect_to question
    end
  end

  describe 'DELETE #delete_file' do
    let(:answer) { create(:answer, :with_files, question: question, user: user) }

    it 'deletes file attached to the answer' do
      expect { delete :delete_file, params: { id: answer, file_id: answer.files.first.id } }.to change(answer.files, :count).by(-1)
    end

    it "redirects to the answer's question show view" do
      delete :delete_file, params: { id: answer, file_id: answer.files.first.id }
      expect(response).to redirect_to question
    end
  end
end
