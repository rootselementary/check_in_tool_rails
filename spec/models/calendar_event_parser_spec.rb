require 'rails_helper'

RSpec.describe CalendarEventParser, type: :model do
  before do
    Timecop.freeze(Time.parse('2016-08-05 06:00:00 -0600'))
  end

  after do
    Timecop.return
  end

  it "will parse google calendar events into a hash" do
    VCR.use_cassette 'google_calendar_service' do
      grove = create(:grove)
      location = create(:location, name: "breakfast nook",
                                   grove: grove)
      activity = create(:activity, name: "morning stuff",
                                   location: location)
      location2 = create(:location, name: "cafeteria",
                                    grove: grove)
      activity2 = create(:activity, name: "lunch",
                                    location: location2)

      student = create(:student, email: "student@example.org",
                                 refresh_token: "xxxxxxxxxxxxxxyyyyyyyyyyyy",
                                 grove: grove)

      scheduled_events = CalendarEventParser.parse_events(GoogleService.fetch_events(student))
      expect(scheduled_events.count).to eq(2)
      first_event = scheduled_events.first
      expect(first_event.class).to eq(Hash)
      expect(first_event[:start_time]).to eq("2016-08-05T19:30:00Z")
      expect(first_event[:end_time]).to eq("2016-08-05T22:00:00Z")
      expect(first_event[:title]).to eq("morning stuff")
    end
  end
end
