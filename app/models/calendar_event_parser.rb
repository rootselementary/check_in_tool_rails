module CalendarEventParser
  def self.parse_events(events)
    # [Google::Event]
    events.map do |event|
      s = Time.zone.parse(event.start_time)
      e = Time.zone.parse(event.end_time)
      {
       start_time: s,
       end_time: e,
       duration: e.to_i - s.to_i,
       title: event.title,
       location_id: Location.find_by_location(event.location).try(:id),
       creator_id: self.creator(event.raw).try(:id),
       metadata: event.to_json
      }
    end
  end

  def self.creator(raw)
    email = raw.fetch('creator', {}).fetch('email', nil)
    user = nil
    if email
      user = User.where(email: email).first
    end
    user
  end
end
