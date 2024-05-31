FactoryBot.define do
  factory :user do
    sequence(:id) { |i| "#{i}" } 
    name {"YAMADA"}
    sequence(:email) { |i| "test#{i}.email.com" } 
    password {"password"}
    password_confirmation {"password"}
  end
end