class Timecard < ActiveRecord::Base
    belongs_to :user

		# PUT FUNCTION TO CALCULATE TIME HERE
		#def test
		#	Timecard.start_time
		#end
end
