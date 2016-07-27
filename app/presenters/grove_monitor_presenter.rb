class GroveMonitorPresenter
  attr_reader :lost_students, :absent_students, :locations
  def initialize(locations)
    @absent_students = Student.absent
    @lost_students = Student.lost
    @locations = {}
    locations.each do |location|
      @locations[location.name] = Student.location(location.name) || []
    end
  end
end
