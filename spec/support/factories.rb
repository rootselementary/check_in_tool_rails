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
    google_image "http://placekitten.com/300/300"
    association :grove

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
      at_school true

    end
  end

  factory :grove do
    sequence(:name) { |n| "Grove #{n}" }
    master_calendar [[8, 0], [14, 45]]

    factory :grove_with_students do
      after(:create) do |grove|
        create(:teacher, grove: grove)
        create_list(:student, 2, grove: grove)
      end
    end

    factory :grove_with_resources do
      after(:create) do |grove|
        student1, student2 = create_list(:student, 2, grove: grove)
        create_list(:teacher, 2, grove: grove)
        location1, location2 = create_list(:location, 2, grove: grove)
        activity, _ = create_list(:activity, 2, grove: grove, location: location1)
        focus_area = create(:focus_area, grove: grove)
        create(:playlist_activity, activity: activity, student: student1, focus_area: focus_area)
        event = create(:event, student: student1, location: location1)
        event2 = create(:event, student: student2, location: location1)
        scan = create(:scan, location: location2)
        scan2 = create(:scan, location: location1)
      end
    end

    factory :grove_with_absent_students do
      after(:create) do |grove|
        student1, student2 = create_list(:student, 2, grove: grove)
        create(:teacher, grove: grove)
        location1, location2 = create_list(:location, 2, grove: grove)
        activity = create(:activity, grove: grove, location: location1)
        focus_area = create(:focus_area, grove: grove)
        create(:playlist_activity, activity: activity, student: student1, focus_area: focus_area)
        event = create(:event, student: student1, location: location1)
        event2 = create(:event, student: student2, location: location1)
        scan = create(:scan, location: location2)
        scan2 = create(:scan, location: location1)
      end
    end

    factory :grove_with_scanned_in_students do
      after(:create) do |grove|
        student1, student2 = create_list(:student, 2, grove: grove)
        create(:teacher, grove: grove)
        location = create(:location, grove: grove)
        activity = create(:activity, grove: grove, location: location)
        focus_area = create(:focus_area, grove: grove)
        create(:playlist_activity, activity: activity, student: student1, focus_area: focus_area)
        event = create(:event, student: student1, location: location)
        event2 = create(:event, student: student2, location: location)
        scan = create(:scan, location: location, student: student1, scanned_in_at: 1.minute.ago, expires_at: event.end_time, correct: true)
        scan2 = create(:scan, location: location, student: student2, scanned_in_at: 1.minute.ago, expires_at: event2.end_time, correct: true)
      end
    end
  end

  factory :school do
    name "Roots Elementary"
  end

  factory :activity do
    sequence(:title) { |n| "Fun Activity #{n}" }
    association :grove
    association :location
  end

  factory :focus_area do
    sequence(:name) { |n| "Focus up #{n}" }
    grove nil
  end

  factory :location do
    sequence(:name) { |n| "Amazing Location #{n}" }
    association :grove
  end

  factory :playlist_activity do
    student nil
    activity nil
    focus_area nil
    position 0
  end

  factory :event do
    student nil
    association :location
    start_time Time.now
    end_time Time.now + 60*60
  end

  factory :scan do
    association :activity
    association :location
    association :student
    scanned_in_at Time.now
    expires_at Time.now + 3600
    correct false
  end
end
