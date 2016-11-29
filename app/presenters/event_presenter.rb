class Panel
  attr_accessor :image, :content
  def initialize(event) ; self ; end
end

# location
class LeftPanel < Panel

  def initialize(event)
    if event.location.present?
      @content = event.location.titleized_name
      @image = event.location.image_url
    else
      @content = event.metadata['location'].try(:titlecase)
    end
    super
  end

end

# activity
class MiddlePanel < Panel

  def initialize(event)
    @content = event.title || event.activity.title
    if event.activity.present?
      @image = event.activity.image_url
    end
    @content = @content.titlecase
    super
  end

end

# focus area or creator of event
class RightPanel < Panel

  def initialize(event)
    if event.creator.present?
      @content = event.creator.name
      @image = event.creator.google_image
    else
      if event.focus_area.present?
        @content = event.focus_area.name
        @image = event.focus_area.image
      end
    end

    super
  end

end

class EventPresenter

  attr_accessor :event
  delegate :scanned_in?, to: :event

  # initialize
  # @param event [Event] the event to decorate
  # @param ongoing [Boolean] whether or not the event is the current event
  # @return [EventPresenter]
  def initialize(event, ongoing=false)
    @event = event
    @ongoing = ongoing
  end

  def left_panel
    LeftPanel.new(@event)
  end

  def middle_panel
    MiddlePanel.new(@event)
  end

  def right_panel
    RightPanel.new(@event)
  end

  def id
    @event.id
  end

  def empty?
    @event.nil?
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
