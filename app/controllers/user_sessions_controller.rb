class UserSessionsController < ApplicationController

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_back_or_to mysteries_path
    else
      render :new
    end
  end


def destroy
  logout
  redirect_to root_path
end

end
