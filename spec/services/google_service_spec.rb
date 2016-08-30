require 'rails_helper'

feature 'Google Calendar Request' do
  before do
    Timecop.freeze(Time.parse('2016-08-05 06:00:00 -0600'))
  end

  after do
    Timecop.return
  end

  it 'Will return list of scheduled events' do
    VCR.use_cassette 'google_calendar_service' do

      student = create(:student, email: "student@example.org",
                               refresh_token: "xxxxxxxxxxxxxxyyyyyyyyyyyy")

      response = GoogleService.fetch_events(student)
      expect(response.count).to eq(2)
      expect(response.first.class).to eq(Google::Event)
      expect(response.first.start_time).to eq("2016-08-05T15:30:00Z")
      expect(response.first.end_time).to eq("2016-08-05T16:00:00Z")
      expect(response.first.location).to eq("Breakfast Nook")
      expect(response.first.title).to eq("morning stuff")
    end
  end
end
