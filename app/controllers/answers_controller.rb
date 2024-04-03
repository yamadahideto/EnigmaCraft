class AnswersController < ApplicationController
  before_action :require_login, except: %i[new create]
  def new
    @answer = Answer.new
  end

  def create
    @answer = current_user.answers.new(answer_params)
    user_answer = @answer.response
    correct_answer = Mystery.find(params[:mystery_id]).correct_answer
    if @answer.check_answer(user_answer, correct_answer)
      @answer.correct_flag = true
      if @answer.save
        flash[:notice] = '正解しました!'
        redirect_to mysteries_path
      else
        # saveの失敗時の処理
        flash.now[:alert] = '回答が正しく保存できませんでした。'
        @mystery = Mystery.find(params[:mystery_id])
        render 'mysteries/show', status: :unprocessable_entity
      end
    else
      # 問題に不正解時の処理
      flash.now[:alert] = '不正解です!'
      @mystery = Mystery.find(params[:mystery_id])
      render 'mysteries/show', status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:response)
  end
end
