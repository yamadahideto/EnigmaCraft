FactoryBot.define do
  factory :answer do
    association :user
    association :mystery
    correct_flag { true }
  end
end
