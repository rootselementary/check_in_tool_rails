class CompassPresenter

  def initialize(student)
    @events = student.compass_events
    @current_event = EventPresenter.new(@events[0], true)
    @next_event = EventPresenter.new(@events[1])
  end

  def events
    if @next_event.empty?
      [@current_event]
    else
      [@current_event, @next_event]
    end
  end

  class EventPresenter

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
      @event.activity.try(:title)
    end

    def location_image
      @event.location.image_url || "location-default.png"
    end

    def location_name
      @event.location.titleized_name
    end

    def location_id
      @event.location.id
    end

    def creator_image
      @event.creator.try(:google_image) || "grove-default.png"
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

end
