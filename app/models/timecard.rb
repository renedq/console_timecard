class Timecard < ActiveRecord::Base
    belongs_to :user
		belongs_to :unit

		# PUT FUNCTION TO CALCULATE TIME HERE
		#def test
		#	Timecard.start_time
		#end
end
