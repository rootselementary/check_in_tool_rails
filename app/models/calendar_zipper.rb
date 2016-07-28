class CalendarZipper

  TRANSITION = 120 # 2 min transition period

  def initialize(master_calendar, activities, playlist)
    @master_calendar = master_calendar
    @activities      = activities
    @playlist        = playlist
  end

  def schedule
    data = { schedule: [], activities: @activities, playlist: @playlist }
    daily_schedule = @master_calendar.each_cons(2).inject(data) do |acc, (start_time, end_time)|
      playlist = acc[:playlist]
      activities = relevant_activities(acc[:activities], start_time, end_time)
      if activities.present?
        schedule = apply_activities(acc[:schedule], activities)
      else
        schedule = apply_playlist_items(acc[:schedule], playlist.take(3))
        playlist.rotate!(3)
      end
      { schedule: schedule, activities: (acc[:activities] - activities), playlist: playlist }
    end
    daily_schedule[:schedule]
  end

  def apply_playlist_items(schedule, items)
    items.inject(schedule) do |acc, i|
      acc << {name: i[:name], duration: 900}
    end
  end

  def apply_activities(schedule, activities)
    activities.inject(schedule) do |acc, a|
      duration = (a[:end_time] - a[:start_time]).to_i
      acc << { name: a[:name], duration: duration }
      acc
    end
  end

  def relevant_activities(activities, start_time, end_time)
    r = to_range(start_time, end_time)
    activities.select { |e| r.cover?(e[:start_time]) }
  end

  def to_range(start_time, end_time)
    Range.new(to_time(start_time), to_time(end_time), exclude_end: true)
  end

  def to_time(tuple)
    Time.zone.now.change(hour: tuple[0], min: tuple[1])
  end
end
