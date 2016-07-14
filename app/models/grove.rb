class Grove < ActiveRecord::Base
  belongs_to :school
  has_many :users, dependent: :nullify
  has_many :students
  has_many :teachers

  validates :name, presence: true, uniqueness: true

  def teachers
    Teacher.where(grove: self)
  end
end
