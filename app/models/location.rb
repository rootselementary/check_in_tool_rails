class Location < ActiveRecord::Base
  belongs_to :grove
  has_many :activities, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :name, presence: true

  mount_uploader :image, ImageUploader

  before_save :normalize_name

  def self.find_by_location(location)
    return nil if location.nil?
    where("name LIKE '%#{location.downcase}%'").first
  end

  def grove_name
    grove.name
  end

  def titleized_name
    name.titlecase
  end

  private

  def normalize_name
    self.name = self.name.downcase
  end
end
