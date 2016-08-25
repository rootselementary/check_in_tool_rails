class Grove < ActiveRecord::Base

  # TODO: make these configurable on the grove
  TRANSITION = 120 # 2 min transition period
  FLEX_INTERVAL = 900 # 15

  belongs_to :school
  has_many :users, dependent: :nullify
  has_many :students
  has_many :teachers
  has_many :locations
  has_many :focus_areas
  has_many :activities

  mount_uploader :image, ImageUploader

  validates :name, presence: true, uniqueness: true

  def teachers
    Teacher.where(grove: self)
  end
end
