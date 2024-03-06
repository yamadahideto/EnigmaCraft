class MysteriesController < ApplicationController
  before_action :set_mystery, only: %i[:show :edit :update :destroy]
  before_action :require_login, only: %i[:new :edit :update :destroy]
  
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
      redirect_to mysteries_path
    else
      render :index
    end
  end

  def edit
  end

  def update
    if @mystery.update(mystery_params)
      redirect_to mysteries_path
    else
      render :index
    end
  end

  def destroy
    @mystery.destroy!
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
