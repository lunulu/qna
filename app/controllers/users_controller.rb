class UsersController < ApplicationController
  def rewards
    @user = User.find(params[:id])
    @rewards = @user.rewards
  end
end
