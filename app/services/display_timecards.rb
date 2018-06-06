class DisplayTimecards
  def initialize(user)
    @user = user
  end

  def call
    d = DateTime.now.utc
    mon_total = 0
    for ts in @user.timecards.where("end_time > ?", d.beginning_of_month)
      if ts.end_time
        mon_total += (ts.end_time - ts.start_time)
      end
    end

    quarter_total = 0
    for ts in @user.timecards.where("end_time > ?", d.beginning_of_quarter)
      if ts.end_time
        quarter_total += (ts.end_time - ts.start_time)
      end
    end

    year_total = 0
    fy = d.beginning_of_year - 3.month
    if d.month > 9
      fy += 1.year
    end
    for ts in @user.timecards.where("end_time > ?", fy)
      if ts.end_time
        year_total += (ts.end_time - ts.start_time)
      end
    end
    { 
      "user" =>     @user,
      "month" =>    (mon_total/60/60).round(2),
      "quarter" =>  (quarter_total/60/60).round(2),
      "fy" =>       (year_total/60/60).round(2)
    }
  end
end
