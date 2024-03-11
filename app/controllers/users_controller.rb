class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new   
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      flash[:notice] = t('flash.messages.success', text: User.model_name.human )
      redirect_back_or_to mysteries_path
    else
      flash.now[:alert] = t('flash.messages.error', text: User.model_name.human) 
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:avator, :name, :email, :password, :password_confirmation) 
  end

end
