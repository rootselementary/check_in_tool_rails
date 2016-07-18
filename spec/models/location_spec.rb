require 'rails_helper'

RSpec.describe Location, type: :model do
  it { should belong_to :grove }
  it { should have_many(:activities) }
end
