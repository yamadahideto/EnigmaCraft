FactoryBot.define do
  factory :mystery do
    association :user
    association :genre
    title { '過去の盛り上がり' }
    content { '終わったことを後悔する様子' }
    correct_answer { '後の祭り' }
  end
end
