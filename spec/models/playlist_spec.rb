require 'rails_helper'

RSpec.describe Playlist, type: :model do
  it { should belong_to :student }
  it { should have_many :playlist_activities }
end
