class GroveMonitorLocation

  attr_reader :location

  # @param [String] location_name
  def initialize(location_name)
    @location = Location.find_by_name(location_name)
  end

  def expected
    Student.expected_at_location(@location.id)
  end

  def unexpected
    Student.at_location(@location.id)
  end
end
