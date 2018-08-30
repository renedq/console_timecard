require 'pry'
require 'date'

module Admin
	class UsersController < ApplicationController
		before_action :set_user, only: [:show, :edit]

		def index
			@users = User.all.order(last_name: :asc)
		end

		def new
			binding.pry
			@user = User.new
		end

		def show
			@total = DisplayTimecards.new(@user).call 
			timecards = []
			#TODO don't need this anymore
			for timecard in @user.timecards.order(start_time: :desc) do
				record = {"start_time": timecard.start_time, "hours": timecard.hours, "id": timecard.id}
				timecards.append(record)
			end
			@timecards = timecards
		end

		def edit
			binding.pry
			pass
		end
		
		private def set_user
			@user = User.find(params[:id])
		end
	end
end
