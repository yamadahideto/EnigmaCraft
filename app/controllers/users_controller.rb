class UsersController < ApplicationController

  def new   
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user = login(user_params[:email], user_params[:password])
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
