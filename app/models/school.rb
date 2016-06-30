class School < ActiveRecord::Base
  has_many :groves
  has_many :users
end
