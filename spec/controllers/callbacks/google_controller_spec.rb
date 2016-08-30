require 'rails_helper'

RSpec.describe 'Push Notifications', type: :request do
  before { Timecop.freeze(2016, 8, 10) }
  after { Timecop.return
  }
  it 'updates student schedule upon change from Google Calendar' do
    VCR.use_cassette 'google_callback_controller' do
      student = create(:student, email: "student@example.org", refresh_token: "xxxxxxxxxxxxxxyyyyyyyyyyyy")
      expect(UpdateScheduleJob).to receive(:perform_now).with(student.id).and_return(true)
      headers = {
        "ACCEPT" => "application/json",
        "HTTP_X_GOOG_CHANNEL_ID" => "student-#{student.id}"
      }

      post '/notifications', 
        params: { test: { name: "Test Data" } }, 
        headers: headers
        
      expect(response.status).to eq(201)
  end
  end
end
