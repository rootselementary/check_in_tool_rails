require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should belong_to :student }
  it { should belong_to :location }
  it { should have_many :scans }
end
