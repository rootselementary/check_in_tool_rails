module CalendarEventParser
  def self.parse_events(events)
    events.map do |event|
      {
       start_time: event.start_time,
       end_time: event.end_time,
       title: event.title,
       location: event.location,
       creator: event.creator_name
      }
    end
  end
end
