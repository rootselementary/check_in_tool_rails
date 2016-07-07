class Grove < ActiveRecord::Base
  belongs_to :school
  has_many :users

  validates :name, presence: true, uniqueness: true
end
