require 'digest'

module ChecksumHelper
  def self.get_checksum(schedule)
    Digest::SHA256.hexdigest(schedule.to_json)
  end
end
