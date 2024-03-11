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
      flash[:notice] = t('flash.messages.create', text: Mystery.model_name.human )
      redirect_to mysteries_path
    else
      flash[:alert] = t('flash.messages.not_create', text: Mystery.model_name.human )
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @mystery.update(mystery_params)
      flash[:notice] = t('flash.messages.updated', text: Mystery.model_name.human )
      redirect_to mysteries_path
    else
      flash[:notice] = t('flash.messages.not_updated', text: Mystery.model_name.human )
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @mystery.destroy!
      flash[:notice] = t('flash.messages.deleted', text: Mystery.model_name.human )
    redirect_to mysteries_path, status: :see_other
  end

  private

  def mystery_params
    params.require(:mystery).permit(:title, :mystery_type, :image, :content, :correct_answer)
  end

  def set_mystery
    @mystery = Mystery.find(params[:id])
  end
end
