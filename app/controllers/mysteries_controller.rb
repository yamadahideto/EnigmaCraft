class MysteriesController < ApplicationController
  before_action :set_mystery, only: %i[edit update destroy]
  before_action :set_genre, except: %i[show destroy]
  before_action :require_login, only: %i[new edit update destroy]
  def index
    @q = Mystery.ransack(params[:q])
    @mysteries = @q.result.includes(%i[genre bookmarks]).order(id: :DESC).page(params[:page]).per(6)
  end

  def show
    @mystery = Mystery.find(params[:id])
    @answer = Answer.new
  end

  def new
    @mystery = Mystery.new
  end

  def create
    @mystery = current_user.mysteries.new(resize_image(mystery_params))
    if @mystery.save
      flash[:notice] = t('flash.messages.create', text: Mystery.model_name.human)
      # redirect_to mysteries_path
    else
      flash[:alert] = t('flash.messages.not_create', text: Mystery.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  # AI画像生成
  def generate
    @mystery = current_user.mysteries.new(resize_image(mystery_params))
    ActiveRecord::Base.transaction do
      if @mystery.save
        AsyncGenerateJob.perform_later(@mystery.id)
        # flash[:notice] = t('flash.messages.create', text: Mystery.model_name.human)
        # redirect_to mysteries_path
      else
        flash.now[:alert] = t('flash.messages.not_create', text: Mystery.model_name.human)
        render :new, status: :unprocessable_entity
      end
    rescue MysteryGenerate::OpenAiResponseError => e
      flash[:alert] = e.message
      render :new, status: :unprocessable_entity
    end
    # generate_text = MysteryGenerate.generate_text(client, @mystery.genre.name, @mystery.correct_answer)
    # generate_image = MysteryGenerate.generate_image(client, @mystery.genre.name, @mystery.correct_answer)
    # @mystery.title = generate_text[:title]
    # @mystery.content = generate_text[:content]
    # @mystery.image.attach(
    #   io: generate_image[:image],
    #   filename: generate_image[:filename]
    # )
    # rescue MysteryGenerate::OpenAiResponseError => e
    #   flash[:alert] = e.message
    #   render :new, status: :unprocessable_entity
    # end
  end

  def edit; end

  def update
    if @mystery.update(mystery_params)
      flash[:notice] = t('flash.messages.updated', text: Mystery.model_name.human)
      redirect_to mysteries_path
    else
      flash[:notice] = t('flash.messages.not_updated', text: Mystery.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def bookmarks
    @q = current_user.mystery_bookmarks.ransack(params[:q])
    @bookmarks = @q.result.includes(%i[genre bookmarks]).order(id: :DESC).page(params[:page]).per(6)
  end

  def destroy
    # 削除時にS3ストレージの画像も削除
    @mystery.image.purge_later
    @mystery.destroy!
    flash[:notice] = t('flash.messages.deleted', text: Mystery.model_name.human)
    redirect_to mysteries_path, status: :see_other
  end

  private

  def mystery_params
    params.require(:mystery).permit(:title, :genre_id, :image, :content, :correct_answer)
  end

  def set_mystery
    @mystery = current_user.mysteries.find(params[:id])
  end

  def set_genre
    @genres = Genre.all
  end

  def resize_image(params)
    if params[:image]
      params[:image].tempfile = ImageProcessing::MiniMagick
                                .source(params[:image].tempfile)
                                .convert('webp') # webpに変換して保存
                                .call
    end
    params
  end
end
