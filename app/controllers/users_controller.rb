class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create show update edit]
  def new
    @user = User.new
  end

  def create
    @user = User.new(resize_avator(user_params))
    if @user.save
      auto_login(@user)
      flash[:notice] = t('flash.messages.success', text: User.model_name.human)
      redirect_back_or_to mysteries_path
    else
      flash.now[:alert] = t('flash.messages.error', text: User.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(resize_avator(user_params))
      flash[:notice] = t('flash.messages.success', text: User.model_name.human)
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = t('flash.messages.error', text: User.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def rankings
    @users = User.all.order(point: :desc).limit(10)
  end

  private

  def user_params
    params.require(:user).permit(:avator, :name, :email, :password, :password_confirmation)
  end

  def resize_avator(params)
    if params[:avator]
      params[:avator].tempfile = ImageProcessing::MiniMagick
                                 .source(params[:avator].tempfile)
                                 .convert('webp') # webpに変換して保存
                                 .resize_to_limit(300, 300) # リサイズして保存
                                 .call
    end
    params
  end
end
