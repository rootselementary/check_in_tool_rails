require 'rails_helper'

describe TeacherResourcePolicy do
  describe '#show?' do
    it 'permits teachers' do
      teacher = create(:teacher)
      policy = TeacherResourcePolicy.new(teacher, nil)
      expect(policy.show?).to be true
    end

    it 'does not permit students' do
      student = create(:student)
      policy = TeacherResourcePolicy.new(student, nil)
      expect(policy.show?).to be false
    end
  end
end
