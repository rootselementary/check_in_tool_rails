require 'rails_helper'

RSpec.describe PlaylistActivity, type: :model do
  it { should belong_to :playlist }
  it { should belong_to :activity }
  it { should belong_to :focus_area }
end
