class EventPresenter

  # initialize
  # @param event [Event] the event to decorate
  # @param ongoing [Boolean] whether or not the event is the current event
  # @return [EventPresenter]
  def initialize(event, ongoing=false)
    @event = event
    @ongoing = ongoing
  end

  def empty?
    @event.nil?
  end

  def activity_image
    @event.activity.try(:image_url) || "activity-default.png"
  end

  def activity_name
    @event.title || @event.activity.try(:title)
  end

  def location_image
    @event.location.try(:image_url) || "location-default.png"
  end

  def location_name
    @event.location.try(:titleized_name) || "Unknown"
  end

  def location_id
    @event.location.try(:id)
  end

  def creator_image
    @event.creator.try(:google_image)
  end

  def creator_name
    @event.creator.try(:name)
  end

  def scanned_in?
    @event.scanned_in?
  end

  def status_class
    return "enroute hidden" if !@ongoing
    scanned_in? ? "ongoing scanned-in" : "ongoing enroute"
  end

  def end_time
    (@event.end_time.to_i)*1000
  end

  def duration
    (@event.end_time - Time.zone.now - Grove::TRANSITION).to_i * 1000
  end

end
