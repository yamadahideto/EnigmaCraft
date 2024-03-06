class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[:new :create]
  def new   
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_back_or_to mysteries_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation) 
  end

end
