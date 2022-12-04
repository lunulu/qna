require 'rails_helper'

RSpec.describe UsersController do
  let(:user) { create(:user) }
  let(:question) { create(:question, :with_reward) }
  let(:answer) { create(:answer, user: user, question: question) }

  before { login(user) }

  describe 'GET #rewards' do
    before { get :rewards, params: { id: user } }

    it 'assigns requested user to @user' do
      expect(assigns(:user)).to eq user
    end

    it "assigns user's rewards to @rewards" do
      expect(assigns(:rewards)).to eq user.rewards
    end

    it 'renders rewards view' do
      expect(response).to render_template :rewards
    end
  end
end
