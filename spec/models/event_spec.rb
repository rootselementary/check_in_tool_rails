require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to :student }
  it { should belong_to :location }

  describe 'scanned_in?' do
    before { Timecop.freeze }
    after { Timecop.return }

    let(:student) { create(:student) }
    let(:location) { create(:location) }

    it 'finds a scan for a specific event' do
      scan = create(:scan, location: location, student: student, scanned_in_at: 3.minutes.ago, correct: true)
      event = create(:event, student: student, location: location, start_time: 15.minutes.ago, end_time: 30.minutes.from_now)
      expect(event.scans).to include(scan)
      expect(event.scanned_in?).to eq(true)
    end

    it 'does not find scans before the current timeframe' do
      event = create(:event, student: student, location: location, start_time: 15.minutes.ago, end_time: 30.minutes.from_now)
      scan = create(:scan, location: location, student: student, scanned_in_at: 20.minutes.ago, correct: true)
      expect(event.scans).to include(scan)
      expect(event.scanned_in?).to eq(false)
    end

    it 'finds the scan for the upcoming event' do
      event = create(:event, location: location, student: student, start_time: 1.minute.from_now, end_time: 30.minutes.from_now)
      scan = create(:scan, location: location, student: student, scanned_in_at: Time.now, correct: true)
      expect(event.scans).to include(scan)
      expect(event.scanned_in?).to eq(true)
    end

  end
end
