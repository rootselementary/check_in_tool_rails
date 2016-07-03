require 'rails_helper'

RSpec.describe Teacher, type: :model do
  it { should have_many(:user_roles) }
  it { should have_many(:roles) }
end
