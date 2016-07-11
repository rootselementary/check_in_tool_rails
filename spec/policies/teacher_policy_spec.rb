require 'rails_helper'

describe TeacherPolicy do
  describe '#show?' do
    it 'permits teachers' do
      teacher = create(:teacher)
      policy = TeacherPolicy.new(teacher, nil)
      expect(policy.show?).to be true
    end

    it 'does not permit students' do
      student = create(:student)
      policy = TeacherPolicy.new(student, nil)
      expect(policy.show?).to be false
    end
  end
end
