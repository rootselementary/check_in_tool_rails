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
  end

  factory :grove do
    sequence(:name) { |n| "Grove #{n}" }
    factory :grove_with_students do
      after(:create) do |grove|
        create_list(:student, 2, grove: grove)
      end
    end

    factory :grove_with_resources do
      after(:create) do |grove|
        student1, _ = create_list(:student, 2, grove: grove)
        create(:teacher, grove: grove)
        location = create(:location, grove: grove)
        activity = create(:activity, grove: grove, location: location)
        focus_area = create(:focus_area, grove: grove)
        create(:playlist_activity, activity: activity, student: student1, focus_area: focus_area)
      end
    end
  end

  factory :school do
    name "Roots Elementary"
  end

  factory :activity do
    sequence(:name) { |n| "Fun Activity #{n}" }
    grove nil
    location nil
  end

  factory :focus_area do
    sequence(:name) { |n| "Focus up #{n}" }
    grove nil
  end

  factory :location do
    sequence(:name) { |n| "Amazing Location #{n}" }
    grove nil
  end

  factory :playlist_activity do
    student nil
    activity nil
    focus_area nil
    position 1
  end
end
