require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it { should have_many(:user_roles) }
  it { should have_many(:roles) }

  # TODO: this is just a stub spec to show how to use traits.
  it 'can haz roles' do
    teach = create(:teacher, :admin)
    expect(teach.roles.size).to eq(1)
  end
end
