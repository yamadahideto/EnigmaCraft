class MysteriesController < ApplicationController
  before_action :set_mystery, only: %i[edit update destroy]
  before_action :require_login, only: %i[new edit update destroy]

  def index
    @mysteries = Mystery.order(id: :DESC).page(params[:page]).per(9)
  end

  def show
    @mystery = Mystery.find(params[:id])
    @answer = Answer.new
  end

  def new
    @mystery = Mystery.new
  end

  def create
    @mystery = Mystery.new(resize_image(mystery_params))
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil))
    response = client.images.generate(
      parameters: {
        model: 'dall-e-3',
        prompt: "Generates a puzzle-solving image that resembles a ciphertext that abstracts the 「#{@mystery.correct_answer}」 and allows you to reach the answer by association"
      }
    )
    image_url = response.dig('data', 0, 'url')
    downloaded_image = URI.open(image_url)
    @mystery.image.attach(io: downloaded_image, filename: "#{@mystery.correct_answer}.webp")

    if @mystery.save
      flash[:notice] = t('flash.messages.create', text: Mystery.model_name.human)
      redirect_to mysteries_path
    else
      flash[:alert] = t('flash.messages.not_create', text: Mystery.model_name.human)
      render :new, status: :unprocessable_entity
    end
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

  def destroy
    # 削除時にS3ストレージの画像も削除
    @mystery.image.purge_later
    @mystery.destroy!
    flash[:notice] = t('flash.messages.deleted', text: Mystery.model_name.human)
    redirect_to mysteries_path, status: :see_other
  end

  private

  def mystery_params
    params.require(:mystery).permit(:title, :mystery_type, :image, :content, :correct_answer)
  end

  def set_mystery
    @mystery = Mystery.find(params[:id])
  end

  def resize_image(params)
    if params[:image]
      params[:image].tempfile = ImageProcessing::MiniMagick
                                .source(params[:image].tempfile)
                                .convert('webp') # webpに変換して保存
                                # .resize_to_limit(300, 300) # リサイズして保存
                                .call
    end
    params
  end
end
