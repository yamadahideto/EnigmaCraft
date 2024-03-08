class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :destroy]
  
  def create
    @user = login(params[:email], params[:password], remember_me = true)
    if @user
      flash[:notice] = "ログインしました"
      redirect_back_or_to mysteries_path
    else
      flash.now[:alert] = "ログインに失敗しました"   
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    flash[:notice] = "ログアウトに成功しました"
    redirect_to root_path, status: :see_other
  end
end
