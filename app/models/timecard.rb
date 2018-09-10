class Timecard < ActiveRecord::Base
    belongs_to :user
		belongs_to :unit

		validates :hours, numericality: true
end
