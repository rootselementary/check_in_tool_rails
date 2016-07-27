require 'spec_helper'

feature 'Google Calendar Request' do
  it 'Will return list of scheduled events' do
    VCR.use_cassette 'google_service' do
      uri = URI('https://www.googleapis.com/calendar/v3/users/me/calendarList/jj.letest@rootselementary.org')

      response = Net::HTTP.get(uri)

      expect(response).to be_an_instance_of(String)
    end
  end
end
