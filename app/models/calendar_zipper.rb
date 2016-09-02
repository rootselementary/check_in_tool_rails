class CalendarZipper
  attr_reader :playlist

  def initialize(master_calendar, events, playlist)
    @master_calendar  = master_calendar
    @beginning_of_day = to_time(@master_calendar.first)
    @end_of_day       = to_time(@master_calendar.last)
    @events           = events.sort{|a,b| a[:start_time] <=> b[:start_time] }
    @playlist         = playlist
  end

  def schedule
    case @events.length
      when 0 then fill_with_playlist([], @beginning_of_day, @end_of_day)
      when 1 then wrap_with_playlist([], @events.first, @beginning_of_day, @end_of_day)
      else construct_schedule([], @events, @beginning_of_day, @end_of_day)
    end
  end

  def fill_with_playlist(schedule, start_time, end_time)
    schedule + update_playlist(number_of_playlist_items(start_time, end_time), start_time)
  end

  def update_playlist(n, start_time)
    _start_time = start_time.dup
    cycles = @playlist.length > 0 ? (n / @playlist.length.to_f).ceil : 0
    cycles = cycles.zero? ? 1 : cycles
    items = @playlist.cycle(cycles).take(n).inject([]) do |acc, i|
      t = _start_time + Grove::FLEX_INTERVAL
      acc.push i.merge({start_time: _start_time, end_time: t, duration: t.to_i - _start_time.to_i })
      _start_time += Grove::FLEX_INTERVAL
      acc
    end
    @playlist.rotate!(n)
    items
  end

  def construct_schedule(schedule, events, start_time, end_time)
    first, *rest = events
    schedule = wrap_with_playlist(schedule, first, start_time, first[:end_time])
    rest.each_with_index do |activity, i|
      next_activity = rest[i + 1]
      if next_activity
        schedule = wrap_with_playlist(schedule, activity, schedule.last[:end_time], next_activity[:start_time])
      else
        schedule = wrap_with_playlist(schedule, activity, schedule.last[:end_time], end_time)
      end
    end
    schedule
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
    (end_time - start_time).to_i / Grove::FLEX_INTERVAL
  end

  def to_time(tuple)
    Time.zone.now.change(hour: tuple[0], min: tuple[1])
  end
end
