require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should belong_to :grove }
  it { should have_many(:activities) }

  xdescribe 'after save hook' do

    it 'normalizes the location name' do
      location = build(:location, name: 'Library')
      location.save
      expect(location.name).to eq('library')
    end
  end

  describe '.find_by_location' do

    it 'should look up as upper case or lower case' do
      location = create(:location, name: 'library')
      # library = Location.find_by_location('Library')
      expect(Location.find_by_location('Library')).to eq(location)
      expect(Location.find_by_location('library')).to eq(location)
    end

    it 'should find fuzzy matches' do
      location2 = create(:location, name: 'reading room')
      expect(Location.find_by_location('Reading Room')).to eq(location2)
      expect(Location.find_by_location('Reading')).to eq(location2)
    end
  end
end
