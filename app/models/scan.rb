class Scan < ActiveRecord::Base
  belongs_to :event
  belongs_to :location
  belongs_to :student, foreign_key: :user_id
end
