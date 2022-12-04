class UsersController < ApplicationController
  def rewards
    @user = User.preload(:rewards).find(params[:id])
    @rewards = @user.rewards
  end
end
