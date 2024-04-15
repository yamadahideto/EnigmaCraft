class Answer < ApplicationRecord
  belongs_to :mystery
  belongs_to :user
  attr_accessor :response

  def check_answer(user_answer, correct_answer)
    # ユーザーの回答と答えの比較
    user_answer.correct_flag = true if user_answer.response == correct_answer
  end
end
