FactoryGirl.define do
  factory :role do
    name "student"
  end

  factory :user do
    sequence(:name) { |n| "JJ Letest#{n}" }
    sequence(:email) { |n| "letest#{n}@example.com" }
    sequence(:password) { |n| "password" }
  end

  factory :grove do
    name "Grove 1"
  end

  factory :school do
    name "Roots Elementary"
  end
end
