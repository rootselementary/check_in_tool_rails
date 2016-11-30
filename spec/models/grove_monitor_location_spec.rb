require 'rails_helper'

describe GroveMonitorLocation do

  let(:unexpected_student) { create(:student, name: "unexpected") }
  let(:expected_student) { create(:student, name: "expected") }
  let(:location) { create(:location) }

  subject { described_class.new(location.name) }

  before { create(:event, student: expected_student, location: location) }
  before {create(:scan, student: unexpected_student, location: location, correct: false) }

  describe '#expected' do
    it 'identifies the expected students at a location' do
      expect(subject.expected).to eq([expected_student])
    end
  end

  describe '#unexpected' do
    it 'identifies the unexpected students at a location' do
      expect(subject.unexpected).to eq([unexpected_student])
    end
  end

end
