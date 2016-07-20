class Event < ActiveRecord::Base
  belongs_to :location
  belongs_to :student, foreign_key: :user_id
  has_many :scans
end
