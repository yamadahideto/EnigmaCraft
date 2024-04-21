class MysteriesController < ApplicationController
  before_action :set_mystery, only: %i[edit update destroy]
  before_action :require_login, only: %i[new edit update destroy]
  def index
    @genres = Genre.all
    @q = Mystery.ransack(params[:q])
    @mysteries = @q.result.order(id: :DESC).page(params[:page]).per(9)
  end

  def show
    @mystery = Mystery.find(params[:id])
    @answer = Answer.new
  end

  def new
    @mystery = Mystery.new
    @genres = Genre.all
  end

  def create
    @mystery = current_user.mysteries.new(resize_image(mystery_params))
    if @mystery.save
      flash[:notice] = t('flash.messages.create', text: Mystery.model_name.human)
      redirect_to mysteries_path
    else
      @genres = Genre.all
      flash[:alert] = t('flash.messages.not_create', text: Mystery.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  # AI画像生成
  def generate
    @mystery = current_user.mysteries.new(resize_image(mystery_params))
    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil))
    response = client.images.generate(
      parameters: {
        model: 'dall-e-3',
        # prompt: "Generates a puzzle-solving image that resembles a ciphertext that abstracts the 「#{@mystery.correct_answer}」 and allows you to reach the answer by association"
        prompt: "「#{@mystery.genre.name}」の「#{@mystery.correct_answer}」を抽象化して論理的に答えにたどり着ける問題を考えてください。ただし直接的な表現は避け、画像で生成してください"
      }
    )
    image_url = response.dig('data', 0, 'url')
    downloaded_image = URI.open(image_url)
    @mystery.image.attach(io: downloaded_image, filename: "#{@mystery.correct_answer}.webp")

    client = OpenAI::Client.new(access_token: ENV.fetch('OPENAI_ACCESS_TOKEN', nil))
    response = client.chat(
      parameters: {
        model: 'gpt-4',
        messages: [
          { role: 'system', content: 'あなたは暗号文のような謎解きを考えるプロです' },
          { role: 'user', content: "「#{@mystery.genre.name}」の「#{@mystery.correct_answer}」を抽象化して連想で答えに辿りつける問題を考えてください。ただし直接的な表現は避け、200字程度のタイトルと問題文をのみを生成してください。タイトルは「」で囲み、最後に/を入れてください 問題は*の後に続けてください" }
        ],
        temperature: 0.7
      }
    )

    # 生成されるレスポンスからタイトルを抽出
    @mystery.title = response.dig('choices', 0, 'message', 'content').match(%r{^(.*?)(?=/)})
    # 生成されるレスポンスから問題文を抽出
    @mystery.content = response.dig('choices', 0, 'message', 'content').match(/\*(.*)$/)

    if @mystery.save
      flash[:notice] = t('flash.messages.create', text: Mystery.model_name.human)
      redirect_to mysteries_path
    else
      @genres = Genre.all
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
    params.require(:mystery).permit(:title, :genre_id, :image, :content, :correct_answer)
  end

  def set_mystery
    @mystery = current_user.mysteries.find(params[:id])
    @genres = Genre.all
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
