class Answer < ApplicationRecord
  belongs_to :mystery
  belongs_to :user
  attr_accessor :response

  def check_answer(user_answer, correct_answer)
    user_answer == correct_answer
  end
end
