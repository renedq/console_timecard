class DisplayTimecards
  def initialize(user, fy=Time.now)
    @user = user
		@fy = fy
  end

  def call
    fy = @fy.beginning_of_year - 3.month

    data = { "user" => @user }
    year_total=0
    
    b = fy
    12.times do
      e = b.end_of_month
      mon_total = 0.0
      
      for ts in @user.timecards.where(start_time: b..e)
              mon_total += ts.hours
      end
      year_total += mon_total

      data[b.strftime("%b").downcase()] = mon_total

      b+=1.month
    end
    data['fy'] = year_total
    data
  end
end
