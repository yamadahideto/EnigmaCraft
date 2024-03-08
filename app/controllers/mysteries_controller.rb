class MysteriesController < ApplicationController
  before_action :set_mystery, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :edit, :update, :destroy]
  
  def index
    @mysteries = Mystery.all
  end

  def show
  end

  def new
    @mystery = Mystery.new
  end

  def create
    @mystery = Mystery.new(mystery_params)
    if @mystery.save
      flash[:notice] = "謎の作成に成功しました"
      redirect_to mysteries_path
    else
      flash.now[:alert] = "謎の作成に失敗しました"  
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @mystery.update(mystery_params)
      flash[:notice] = "謎の更新に成功しました"
      redirect_to mysteries_path
    else
      flash.now[:alert] = "謎の編集に失敗しました"  
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mystery.destroy!
    flash[:notice] = "謎の削除に成功しました"
    redirect_to mysteries_path, status: :see_other
  end

  private

  def mystery_params
    params.require(:mystery).permit(:title, :mystery_type, :content, :correct_answer)
  end

  def set_mystery
    @mystery = Mystery.find(params[:id])
  end
end
