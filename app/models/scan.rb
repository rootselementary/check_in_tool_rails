class Scan < ActiveRecord::Base
  belongs_to :location
  belongs_to :student, foreign_key: :user_id
  belongs_to :activity

end
