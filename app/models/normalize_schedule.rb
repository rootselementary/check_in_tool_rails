class NormalizeSchedule
  attr_reader :hash
  
  def initialize(sched)
    @hash = {
      title:        sched['title'],
      location_id:  sched['location_id'],
      start_time:   sched[:start_time],
      end_time:     sched[:end_time]
    }
  end
end
