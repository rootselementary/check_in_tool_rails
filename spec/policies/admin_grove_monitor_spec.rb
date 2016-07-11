require 'rails_helper'

describe AdminGroveMonitorPolicy do
  describe '#show?' do
    it 'permits teachers' do
      teacher = create(:teacher)
      policy = AdminGroveMonitorPolicy.new(teacher, nil)
      expect(policy.show?).to be true
    end

    it 'does not permit students' do
      student = create(:student)
      policy = AdminGroveMonitorPolicy.new(student, nil)
      expect(policy.show?).to be false
    end
  end
end
