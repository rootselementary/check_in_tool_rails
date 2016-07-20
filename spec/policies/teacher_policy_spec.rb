require 'rails_helper'
describe TeacherPolicy do
  describe '#index?' do
    it 'permits admins' do
      admin = create(:teacher, :admin)
      resource = create(:teacher)
      policy = described_class.new(admin, resource)
      expect(policy.index?).to be true
    end
  end
end 