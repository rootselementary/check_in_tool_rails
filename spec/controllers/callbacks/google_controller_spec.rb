require 'rails_helper'

RSpec.describe 'Push Notifications', type: :request do
  xit 'updates student schedule upon change from Google Calendar' do
    VCR.use_cassette 'google_callback_controller' do
      student = create(:student, email: "student@example.org", refresh_token: "xxxxxxxxxxxxxxyyyyyyyyyyyy")
      headers = {
        "ACCEPT" => "application/json",
        "HTTP_X_GOOG_CHANNEL_ID" => "student-#{student.id}"
      }

      post '/notifications', { :test => {:name => "Test Data"} }, headers
      binding.pry
      expect(response).to eq("hi")
  end
  end
end
