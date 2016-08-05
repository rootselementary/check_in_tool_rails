class CalendarZipper
  attr_reader :playlist

  TRANSITION = 120 # 2 min transition period
  FLEX_INTERVAL = 900 # 15 min
  PERIOD_LENGTH = 2700 # 45 min

  def initialize(master_calendar, activities, playlist)
    @master_calendar  = master_calendar
    @beginning_of_day = to_time(@master_calendar.first)
    @end_of_day       = to_time(@master_calendar.last) + PERIOD_LENGTH
    @activities       = activities.sort{|a,b| a[:start_time] <=> b[:start_time] }
    @playlist         = playlist
  end

  def schedule
    case @activities.length
      when 0 then fill_with_playlist([], @beginning_of_day, @end_of_day)
      when 1 then wrap_with_playlist([], @activities.first, @beginning_of_day, @end_of_day)
      else construct_schedule([], @activities, @beginning_of_day, @end_of_day)
    end
  end

  def fill_with_playlist(schedule, start_time, end_time)
    schedule + update_playlist(number_of_playlist_items(start_time, end_time), start_time)
  end

  def update_playlist(n, start_time)
    _start_time = start_time.dup
    # This next line will blow up if there is nothing on the schedule. It should never happen but
    # is this something we should account for?
    cycles = (n / @playlist.length.to_f).ceil
    cycles = cycles.zero? ? 1 : cycles
    items = @playlist.cycle(cycles).take(n).inject([]) do |acc, i|
      acc.push i.merge({start_time: _start_time, end_time: _start_time + FLEX_INTERVAL})
      _start_time += FLEX_INTERVAL
      acc
    end
    @playlist.rotate!(n)
    items
  end

  def construct_schedule(schedule, activities, start_time, end_time)
    first, *middle, last = activities
    schedule = wrap_with_playlist(schedule, first, start_time, first[:end_time])
    middle.each_with_index do |activity, i|
      next_activity = middle[i + 1]
      if next_activity
        schedule = wrap_with_playlist(schedule, activity, schedule.last[:end_time], middle[i + 1][:start_time])
      else
        schedule = wrap_with_playlist(schedule, activity, schedule.last[:end_time], activity[:end_time])
      end
    end
    schedule = wrap_with_playlist(schedule, last, schedule.last[:end_time], end_time)
  end

  def wrap_with_playlist(schedule, activity, start_time, end_time)
    if activity[:start_time] == start_time
      n_items = number_of_playlist_items(activity[:end_time], end_time)
      schedule + [activity] + update_playlist(n_items, activity[:end_time])
    else
      before = update_playlist number_of_playlist_items(start_time, activity[:start_time]), start_time
      after = update_playlist number_of_playlist_items(activity[:end_time], end_time), activity[:end_time]
      schedule + before + [activity] + after
    end
  end

  def number_of_playlist_items(start_time, end_time)
    (end_time - start_time).to_i / FLEX_INTERVAL
  end

  def to_time(tuple)
    Time.zone.now.change(hour: tuple[0], min: tuple[1])
  end
end
