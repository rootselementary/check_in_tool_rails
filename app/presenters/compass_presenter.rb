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

end
