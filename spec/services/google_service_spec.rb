require 'rails_helper'

feature 'Google Calendar Request' do
  before do
    Timecop.freeze(Time.parse('2016-08-02 11:17:30 -0600'))
  end

  after do
    Timecop.return
  end

  it 'Will return list of scheduled events' do
    VCR.use_cassette 'google_calendar_service' do
      student = Student.create(email: "jj.letest@rootselementary.org",
                               refresh_token: ENV['REFRESH_TOKEN'],
                               password: "password")

      response = GoogleService.fetch_events(student)
      expect(response.count).to eq(3)
      expect(response.first.class).to eq(Google::Event)
      expect(response.first.start_time).to eq("2016-08-02T16:30:00Z")
      expect(response.first.end_time).to eq("2016-08-02T18:00:00Z")
      expect(response.first.location).to eq("writing center")
      expect(response.first.title).to eq("class time")
    end
  end
end
