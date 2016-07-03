FactoryGirl.define do
  factory :user_role do
    user nil
    role nil
  end

  factory :role do
    name "teacher"
  end

  factory :teacher do
    sequence(:name) { |n| "JJ Leteach#{n}" }
    sequence(:email) { |n| "leteach#{n}@example.com" }
    sequence(:password) { |n| "password" }
  end

  factory :student do
    sequence(:name) { |n| "JJ Letest#{n}" }
    sequence(:email) { |n| "letest#{n}@example.com" }
    sequence(:password) { |n| "password" }
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
