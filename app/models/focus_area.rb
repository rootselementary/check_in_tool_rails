class FocusArea < ActiveRecord::Base
  belongs_to :grove

  def grove_name
    grove.name
  end
end
