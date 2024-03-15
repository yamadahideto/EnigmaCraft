class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new   
    @user = User.new
  end

  def create
    @user = User.new(resize_avator(user_params))
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

  def resize_avator(params)
    if params[:avator]
      params[:avator].tempfile = ImageProcessing::MiniMagick
      .source(params[:avator].tempfile)
      .convert("webp") #webpに変換して保存
      .resize_to_limit(300,300) #リサイズして保存
      .call
    end
    params
  end

end
