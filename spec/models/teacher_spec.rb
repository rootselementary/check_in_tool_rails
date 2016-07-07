require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it { should have_many(:user_roles) }
  it { should have_many(:roles) }

  it 'reports if it is an admin' do
    expect(create(:teacher, :admin).admin?).to eq(true)
    expect(create(:teacher).admin?).to eq(false)
  end
end
