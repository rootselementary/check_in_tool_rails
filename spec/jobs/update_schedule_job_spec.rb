require 'rails_helper'

RSpec.describe 'Update Schedule Job' do
  it "sets a schedule in Redis" do
    VCR.use_cassette 'google_calendar_service' do
      grove = create(:grove)
      student = create(:student, email: "jj.letest@rootselementary.org",
                                 refresh_token: ENV['REFRESH_TOKEN'],
                                 grove: grove)

      UpdateScheduleJob.perform(student)
      schedule = student.schedule
      expect(schedule.class).to eq(Redis::HashKey)
      expect(schedule["schedule"].class).to eq(String)
      first_event = JSON.parse(schedule["schedule"]).first
      expect(first_event["start_time"]).to eq("2016-08-03T08:00:00.000Z")
      expect(first_event["end_time"]).to eq("2016-08-03T08:15:00.000Z")
      expect(first_event["title"]).to eq("class time")
    end
  end
end
