class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[:new :create :destroy]
  
  def create
    @user = login(params[:email], params[:password], remember_me = true)
    if @user
      redirect_back_or_to mysteries_path
    else
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end
