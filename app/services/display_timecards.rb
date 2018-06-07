class DisplayTimecards
  def initialize(user)
    @user = user
  end

  def call
    d = DateTime.now.utc
    mon_total = 0.0
    for ts in @user.timecards.where("start_time > ?", d.beginning_of_month)
      mon_total += ts.hours
    end

    quarter_total = 0.0
    for ts in @user.timecards.where("start_time > ?", d.beginning_of_quarter)
      quarter_total += ts.hours
    end

    year_total = 0.0
    fy = d.beginning_of_year - 3.month
    if d.month > 9
      fy += 1.year
    end

    for ts in @user.timecards.where("start_time > ?", fy)
      year_total += ts.hours 
    end
    { 
      "user" =>     @user,
      "month" =>    mon_total,
      "quarter" =>  quarter_total,
      "fy" =>       year_total 
    }
  end
end
