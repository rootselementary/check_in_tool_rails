class ScanCreator

  attr_accessor :event

  # @param student [Student] the student scanning in
  #
  # @param scan_params [Hash] the parameters from the QR reader callback
  # @option scan_params [String] :scanned_data The id of the location scanned by the QR reader
  # @option scan_params [String] :location_name A CGI escaped representation of the location to be scanned in.
  # @option scan_params [String] :event_id The event id the student is intended to check into.
  #
  # @return [ScanCreator]
  def initialize(student, scan_params)
    @student = student
    @scan_params = scan_params
    @scanned_location_id = scan_params[:scanned_data]
    @event = Event.find(scan_params[:event_id])
    self
  end

  # @return [Scan]
  def create
    Scan.create!(student: @student,
                 location_id: @scanned_location_id,
                 scanned_in_at: Time.now,
                 expires_at: @event.end_time,
                 correct: correct?,
                 activity_id: @event.activity_id)
  end

  # @return [String]
  def location_id
    @event.location_id.to_s
  end

  # @return [Boolean]
  def correct?
    location_ids_match?
  end

  # @return [Boolean]
  def location_ids_match?
    location_id == @scanned_location_id
  end

end
