class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guestlogin destroy]
  def new; end

  def create
    @user = login(params[:email], params[:password], true)
    if @user
      flash[:notice] = t('flash.messages.success', text: t('user_sessions.new.login'))
      redirect_back_or_to mysteries_path
    else
      flash.now[:alert] = t('flash.messages.error', text: t('user_sessions.new.login'))
      render :new, status: :unprocessable_entity
    end
  end

  # ゲストログイン
  def guestlogin
    @guest_user = User.create(
      name: 'ゲスト',
      email: "#{SecureRandom.alphanumeric}@email.com",
      password: 'password',
      password_confirmation: 'password'
    )
    auto_login(@guest_user)
    flash[:notice] = t('flash.messages.success', text: t('user_sessions.new.guest_login'))
    redirect_to mysteries_path
  end

  def destroy
    logout
    flash[:notice] = t('flash.messages.success', text: t('user_sessions.new.logout'))
    redirect_to root_path, status: :see_other
  end
end
