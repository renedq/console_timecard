class Timecard < ActiveRecord::Base
    belongs_to :user
		belongs_to :unit

		validates :hours, numericality: true
		validates_presence_of :start_time, :hours
end
