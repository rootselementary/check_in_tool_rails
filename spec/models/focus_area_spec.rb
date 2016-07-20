require 'rails_helper'

RSpec.describe FocusArea, type: :model do
  it { should belong_to :grove }
  
end
