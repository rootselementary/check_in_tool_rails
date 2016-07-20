require 'rails_helper'

RSpec.describe Grove, type: :model do
  it { should belong_to(:school) }
  it { should have_many(:users) }
  it { should have_many(:students) }
  it { should have_many(:teachers) }
  it { should have_many(:locations) }
  it { should have_many(:focus_areas) }
  it { should have_many(:activities) }
end
