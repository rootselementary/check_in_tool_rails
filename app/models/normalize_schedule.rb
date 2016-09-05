class NormalizeSchedule
  attr_reader :hash

  def initialize(sched)
    schedule = sched.symbolize_keys
    @hash = {
      title:        schedule[:title],
      creator_id:   schedule[:creator_id],
      location_id:  schedule[:location_id],
      start_time:   schedule[:start_time],
      end_time:     schedule[:end_time],
      activity_id:  schedule[:activity_id],
      metadata:     schedule[:metadata]
    }
  end
end
