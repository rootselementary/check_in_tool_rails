class Grove < ActiveRecord::Base
  belongs_to :school
  has_many :users
end
