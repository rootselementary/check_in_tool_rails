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
      sequence(:email) { |n| "leteach#{n}@rootselementary.org" }

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
      sequence(:email) { |n| "letest#{n}@rootselementary.org" }
    end

    factory :student_with_activities, class: Student do
      create(:student)
      # after(:build) do |student|
      #   student.playlist.activities << create_list(:student, 2, grove: grove)
      # end
    end

  end

  factory :grove do
    sequence(:name) { |n| "Grove #{n}" }
    factory :grove_with_students do
      after(:create) do |grove|
        create_list(:student, 2, grove: grove)
      end
    end
  end

  factory :school do
    name "Roots Elementary"
  end
end
