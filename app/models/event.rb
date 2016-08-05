class Event < ActiveRecord::Base
  belongs_to :location
  belongs_to :student, foreign_key: :user_id
  belongs_to :activity
  belongs_to :creator, class_name: "Teacher"
  has_many :scans, dependent: :destroy

  def scanned_in?
    !scans.where(correct: true).empty?
  end
end
