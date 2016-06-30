require 'rails_helper'

RSpec.describe School, type: :model do
  it { should have_many(:users) }
  it { should have_many(:groves) }
end
