require 'rails_helper'

describe CompassPolicy do
  describe '#show?' do
    it 'permits students' do
      student = create(:student)
      policy = CompassPolicy.new(student, nil)
      expect(policy.show?).to eq(true)
    end
  end
end
