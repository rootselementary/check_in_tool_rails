require 'rails_helper'

describe LocationPolicy do
  let(:resource) {create(:location) }
  describe '#index?' do
    it 'permits admins' do
      admin = create(:teacher, :admin)
      resource = create(:location)
      policy = described_class.new(admin, nil)
      expect(policy.index?).to be true
    end

    it 'permits teachers' do
      teacher = create(:teacher)
      policy = described_class.new(teacher, nil)
      expect(policy.index?).to be true
    end
  end

  describe '#show?' do

    it 'allows teachers in the same grove' do
      teacher = create(:teacher, grove: resource.grove)
      policy = described_class.new(teacher, resource)
      expect(policy.show?).to be true
    end

    it 'disallows teachers in another grove' do
      teacher = create(:teacher)
      policy = described_class.new(teacher, resource)
      expect(policy.show?).to be false
    end

    it 'permits admins' do
      admin = create(:teacher, :admin)
      resource = create(:location)
      policy = described_class.new(admin, resource)
      expect(policy.show?).to be true
    end
  end
end
