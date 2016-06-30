require 'rails_helper'

RSpec.describe Grove, type: :model do
  it { should belong_to(:school) }
  it { should have_many(:users) }
end
