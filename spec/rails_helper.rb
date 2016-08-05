# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'webmock'
require 'vcr'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveSupport::Dependencies.autoload_paths << "#{Rails.root}/spec/support"

ActiveRecord::Migration.maintain_test_schema!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_localhost = true
end

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end


  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end


  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end


  config.before(:each) do
    DatabaseCleaner.start
  end


  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include FactoryGirl::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def stub_google_calendar_response
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
    headers: {
      "Content-Type": 'application/json'
      },
    provider: 'google',
    "kind": "calendar#events",
    "etag": "\"p32octqs9rulcs0g\"",
    "summary": "jj.letest@rootselementary.org",
    "updated": "2016-08-05T16:56:05.726Z",
    "timeZone": "America/Denver",
    "accessRole": "owner",
    "defaultReminders": [
     {
      "method": "popup",
      "minutes": 10
     }
    ],
    "items": [
     {
      "kind": "calendar#event",
      "etag": "\"2940832270906000\"",
      "id": "aslkdjflasdjklfjasdkljf",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=M2h2aTdzMmVmbXVic2RsNHFyM3Q2OXYxMnMgamoubGV0ZXN0QHJvb3RzZWxlbWVudGFyeS5vcmc",
      "created": "2016-08-04T21:48:25.000Z",
      "updated": "2016-08-05T16:55:35.453Z",
      "summary": "morning stuff",
      "location": "Breakfast Nook",
      "creator": {
       "email": "dev@rootselementary.org"
      },
      "organizer": {
       "email": "dev@rootselementary.org"
      },
      "start": {
       "dateTime": "2016-08-05T13:30:00-06:00"
      },
      "end": {
       "dateTime": "2016-08-05T16:00:00-06:00"
      },
      "iCalUID": "3hvi7sdfdsfsdfqr3t69v12s@google.com",
      "sequence": 0,
      "attendees": [
       {
        "email": "jj.letest@rootselementary.org",
        "displayName": "JJ LeTest",
        "self": true,
        "responseStatus": "needsAction"
       },
       {
        "email": "dev@rootselementary.org",
        "organizer": true,
        "responseStatus": "accepted"
       }
      ],
      "hangoutLink": "https://plus.google.com/hangouts/_/rootselementary.org/dev?hceid=ZGV2QHJvb3RzZWxlbWVudGFyeS5vcmc.3hvi7s2efmubsdl4qr3t69v12s",
      "reminders": {
       "useDefault": true
      }
    },
     {
      "kind": "calendar#event",
      "etag": "\"2940832331030000\"",
      "id": "h4mosdfsdfsdfsd5j13d51a8",
      "status": "confirmed",
      "htmlLink": "https://www.google.com/calendar/event?eid=aDRtbzVuanEwZjF2bzFmZ2Q1ajEzZDUxYTggamoubGV0ZXN0QHJvb3RzZWxlbWVudGFyeS5vcmc",
      "created": "2016-08-04T21:50:09.000Z",
      "updated": "2016-08-05T16:56:05.515Z",
      "summary": "lunch",
      "location": "Cafeteria",
      "creator": {
       "email": "dev@rootselementary.org"
      },
      "organizer": {
       "email": "dev@rootselementary.org"
      },
      "start": {
       "dateTime": "2016-08-05T16:30:00-06:00"
      },
      "end": {
       "dateTime": "2016-08-05T17:30:00-06:00"
      },
      "iCalUID": "h4mo5njq0sdfsdfsdfsd51a8@google.com",
      "sequence": 0,
      "attendees": [
       {
        "email": "dev@rootselementary.org",
        "organizer": true,
        "responseStatus": "accepted"
       },
       {
        "email": "jj.letest@rootselementary.org",
        "displayName": "JJ LeTest",
        "self": true,
        "responseStatus": "needsAction"
       }
      ],
      "hangoutLink": "https://plus.google.com/hangouts/_/rootselementary.org/dev?hceid=ZGV2QHJvb3RzZWxlbWVudGFyeS5vcmc.h4mo5njq0f1vo1fgd5j13d51a8",
      "reminders": {
       "useDefault": true
      }
     }
    ]
    })
end
