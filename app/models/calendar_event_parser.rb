module CalendarEventParser
  def self.parse_events(events)
    # [Google::Event]
    _events = events.map do |event|
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
    _events2 = []
    _events.each_with_index do |e, idx|
      next_event = _events[idx + 1]
      if next_event
        _events2 << e.merge({next_start_time: next_event[:start_time]})
      else
        _events2 << e.merge({next_start_time: e[:end_time]})
      end
    end
    _events2.reject{|e| e[:next_start_time] < e[:end_time]}.inject([]) do |acc, e|
      e.delete(:next_start_time)
      acc << e
      acc
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
