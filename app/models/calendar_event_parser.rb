module CalendarEventParser
  def self.parse_events(events)
    events.map do |event|
      {
       start_time: event.start_time.to_time,
       end_time: event.end_time.to_time,
       title: event.title,
      #  activity_id: Activity.find_by(name: event.title).id,
       location_id: Location.find_by_location(event.location).id,
       creator: event.creator_name,
      #  creator_id: User.find_by(email: event.creator_name).id if event.creator_name,
       metadata: event.to_json
      }
    end
  end
end
