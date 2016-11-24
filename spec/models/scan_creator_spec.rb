require 'rails_helper'

describe ScanCreator do

  describe '.correct?' do

    it 'is correct when the `location_id` and the `scanned_data` match' do
      event = create(:event)
      scan = described_class.new(create(:student), {event_id: event.id, scanned_data: "#{event.location.id}"})

      expect(scan).to be_correct
    end

  end

end
