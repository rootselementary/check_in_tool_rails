require 'rails_helper'

describe StudentManagementPolicy do
  describe '#show?' do
    it 'permits teachers' do
      teacher = create(:teacher)
      student = create(:student)
      policy = StudentManagementPolicy.new(teacher, student)
      expect(policy.show?).to be true
    end

    it 'does not permit students' do
      student = create(:student)
      policy = StudentManagementPolicy.new(student, nil)
      expect(policy.show?).to be false
    end
  end
end
