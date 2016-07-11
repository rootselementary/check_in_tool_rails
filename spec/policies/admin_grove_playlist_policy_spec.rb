require 'rails_helper'

describe AdminGrovePlaylistPolicy do
  describe '#show?' do
    it 'permits teachers' do
      teacher = create(:teacher)
      policy = AdminGrovePlaylistPolicy.new(teacher, nil)
      expect(policy.show?).to be true
    end

    it 'does not permit students' do
      student = create(:student)
      policy = AdminGrovePlaylistPolicy.new(student, nil)
      expect(policy.show?).to be false
    end
  end
end
