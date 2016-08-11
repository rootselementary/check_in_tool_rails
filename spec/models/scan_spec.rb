require 'rails_helper'

RSpec.describe Scan, type: :model do
  it { should belong_to :location }
end
