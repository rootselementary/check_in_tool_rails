class CompassPresenter
  def initialize(student)
    @_event = student.current_event
  end

  def activity_image
    event.activity.image_url
  end

  def activity_name
    event.activity.name
  end

  def location_image
    event.location.image_url
  end

  def location_name
    event.location.name
  end

  def location_id
    event.location.id
  end

  def creator_image
    event.creator.google_image
  end

  def creator_name
    event.creator.name
  end

  def scanned_in?
    event.scanned_in?
  end

  def status_class
    scanned_in? ? "scanned-in" : "enroute"
  end

  def end_time
    (event.end_time.to_i)*1000
  end

  private

    def event
      @_event
    end
end
