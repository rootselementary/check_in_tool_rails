require 'rails_helper'

RSpec.describe CalendarEventParser, type: :model do
  before do
    Timecop.freeze(Time.parse('2016-08-05 06:00:00 -0600'))
  end

  after do
    Timecop.return
  end

  it "filters overlapping events" do
    events = [
      double(:first,  start_time: '2016-08-05 06:00:00 -0600', end_time: '2016-08-05 06:30:00 -0600', to_json: "", title: 'foo', raw: {}, location: ""),
      double(:second, start_time: '2016-08-05 06:30:00 -0600', end_time: '2016-08-05 07:00:00 -0600', to_json: "", title: 'foo', raw: {}, location: ""),
      double(:third,  start_time: '2016-08-05 06:45:00 -0600', end_time: '2016-08-05 07:15:00 -0600', to_json: "", title: 'foo', raw: {}, location: "")
    ]
    schedule = CalendarEventParser.parse_events(events)
    expect(schedule.length).to eq(2)
  end

  it "will parse google calendar events into a hash" do
    VCR.use_cassette 'google_calendar_service' do
      grove = create(:grove)
      location = create(:location, name: "breakfast nook",
                                   grove: grove)
      location2 = create(:location, name: "cafeteria",
                                    grove: grove)

      student = create(:student, email: "student@example.org",
                                 refresh_token: "xxxxxxxxxxxxxxyyyyyyyyyyyy",
                                 grove: grove)

      scheduled_events = CalendarEventParser.parse_events(GoogleService.fetch_events(student))
      expect(scheduled_events.count).to eq(2)
      first_event = scheduled_events.first
      expect(first_event.class).to eq(Hash)
      expect(first_event[:start_time]).to eq("2016-08-05 09:30:00.000000000 -0600")
      expect(first_event[:end_time]).to eq("2016-08-05 10:00:00.000000000 -0600")
      expect(first_event[:duration]).to eq(30.minutes.to_i)

      expect(first_event[:title]).to eq("morning stuff")
    end
  end
end
