class AnswersController < ApplicationController
  before_action :require_login, except: %i[new create]
  def new
    @answer = Answer.new
    @current_user = current_user
  end

  def create
    @answer = current_user.answers.new(answer_params.merge(mystery_id: params[:mystery_id]))
    @mystery = Mystery.find(params[:mystery_id])
    # ユーザーの回答と答えを比較
    if @answer.check_answer(@answer, @mystery.correct_answer)
      if @answer.save
        # 正解時にゲスト以外ならポイント付与
        @current_user.point += 1 unless current_user.guest?
        @current_user.save
        @correct = true
      else
        flash.now[:alert] = '回答が正しく保存できませんでした。'
        @mystery = Mystery.find(params[:mystery_id])
        render 'mysteries/show', status: :unprocessable_entity
      end
    else
      @mystery = Mystery.find(params[:mystery_id])
      @correct = false
      # render 'mysteries/show', status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:response)
  end
end
