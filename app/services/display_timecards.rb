class DisplayTimecards
  def initialize(user)
    @user = user
  end

  def call
    d = DateTime.now.utc
    fy = d.beginning_of_year - 3.month
    if d.month > 9
      fy += 1.year
    end

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
		binding.pry
		data
  end
end
