class Location < ActiveRecord::Base
  belongs_to :grove
  has_many :activities

  mount_uploader :image, ImageUploader

  # before_save :normalize_name

  def self.find_by_location(location)
    where("name LIKE '%#{location.downcase}%'").first
  end

  def grove_name
    grove.name
  end

  private

  def normalize_name
    self.name = self.name.downcase
  end
end
