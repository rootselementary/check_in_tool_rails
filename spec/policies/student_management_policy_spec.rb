require 'rails_helper'

describe StudentManagementPolicy do
  describe '#show?' do

    it 'does permit teachers' do
      teacher = build(:teacher)
      policy = described_class.new(teacher, described_class)
      expect(policy.show?).to be true
    end

    it 'does not permit students' do
      student = build(:student)
      policy = described_class.new(student, nil)
      expect(policy.show?).to be false
    end
  end
end
