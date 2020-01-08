module LocationsHelper
  def calc_end_time(start_time)
    end_time = start_time + 1.hour
  end

  def check_pending_num(location)
    pending_num = location.schedules.pending.size
  end
end
