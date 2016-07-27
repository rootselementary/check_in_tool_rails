require 'rails_helper'

describe LocationPolicy do
  describe '#index?' do
    it 'permits admins' do
      admin = create(:teacher, :admin)
      resource = create(:location)
      policy = described_class.new(admin, resource)
      expect(policy.index?).to be true
    end

    it 'does not permit teachers' do
      teacher = create(:teacher)
      policy = described_class.new(teacher, nil)
      expect(policy.index?).to be false
    end
  end
end
