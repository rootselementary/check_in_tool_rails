require 'rails_helper'

describe AdminDashboardPolicy do
  describe '#show?' do
    it 'permits teachers' do
      teacher = create(:teacher)
      policy = AdminDashboardPolicy.new(teacher, nil)
      expect(policy.show?).to eq(true)
    end
  end
end
