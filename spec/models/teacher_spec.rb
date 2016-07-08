require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it { should have_many(:user_roles) }
  it { should have_many(:roles) }

  it 'reports if it is an admin' do
    expect(create(:teacher, :admin).admin?).to eq(true)
    expect(create(:teacher).admin?).to eq(false)
  end

  describe '#groves' do
    let(:school) { create(:school) }
    let(:aspen) { create(:grove, name: "Aspen", school: school) }

    before { create(:grove, school: school) }

    describe 'when an administrator' do
      let(:teacher) { create(:teacher, :admin, school: school)}
      it 'returns both groves' do
        groves = teacher.groves
        expect(groves).to include(aspen)
        expect(groves.size).to eq(2)
      end
    end

    describe 'without administrative role' do
      let(:teacher) { create(:teacher, school: school, grove: aspen)}

      it 'returns only aspen' do
        expect(teacher.groves).to eq([aspen])
      end
    end
  end
end
