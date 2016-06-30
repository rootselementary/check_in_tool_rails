FactoryGirl.define do
  factory :user do
    name "JJ"
    email "Letest"
    password_digest "password"
  end
  factory :grove do
    name "Grove 1"
  end
  factory :school do
    name "Roots Elementary"
  end
end
