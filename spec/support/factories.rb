FactoryGirl.define do
  factory :user_role do
    user nil
    role nil
  end

  factory :role do
    name "teacher"
  end

  factory :user do
    sequence(:name) { |n| "JJ Letest#{n}" }
    sequence(:email) { |n| "letest#{n}@example.com" }
    password "password"

    factory :teacher, class: Teacher do
      type "Teacher"
      sequence(:name) { |n| "JJ Leteach#{n}" }
      sequence(:email) { |n| "leteach#{n}@example.com" }

        trait :admin do
          after(:build) do |user|
            role = create(:role, name: 'admin')
            user.roles << role
          end
      end
    end

    factory :student, class: Student do
      type "Student"
      sequence(:name) { |n| "JJ Letest#{n}" }
      sequence(:email) { |n| "letest#{n}@example.com" }
    end

  end

  factory :grove do
    name "Grove 1"
  end

  factory :school do
    name "Roots Elementary"
  end
end
