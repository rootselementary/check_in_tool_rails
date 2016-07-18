class Grove < ActiveRecord::Base
  belongs_to :school
  has_many :users, dependent: :nullify
  has_many :students
  has_many :teachers
  has_many :locations
  has_many :focus_areas
  has_many :activities

  validates :name, presence: true, uniqueness: true

  def teachers
    Teacher.where(grove: self)
  end
end
