require 'rails_helper'

RSpec.describe 'Update Schedule Job' do
  before do
    Timecop.freeze(Time.parse('2016-08-05 06:00:00 -0600'))
  end

  after do
    Timecop.return
  end

  it "creates events for daily schedule" do
    VCR.use_cassette 'google_calendar_service' do
      grove = create(:grove)
      location = create(:location, name: "breakfast nook",
                                   grove: grove)
      activity = create(:activity, name: "computer activity",
                                   location: location)
      location2 = create(:location, name: "cafeteria",
                                    grove: grove)
      activity2 = create(:activity, name: "writing activity",
                                    location: location2)
      student = create(:student, email: "student@example.org",
                                 refresh_token: "xxxxxxxxxxxxxxyyyyyyyyyyyy",
                                 grove: grove)
      student.playlist_activities.create(activity: activity,  position: 1)
      student.playlist_activities.create(activity: activity2, position: 2)

      UpdateScheduleJob.perform_now(student.id)
      events = student.events
      expect(events.first.class).to eq(Event)
      first_event = events.first
      expect(first_event.start_time).to eq("2016-08-05T08:00:00.000-06:00")
      expect(first_event.end_time).to eq("2016-08-05T08:15:00.000-06:00")
      expect(first_event.title).to eq("morning stuff")
    end
  end
end
