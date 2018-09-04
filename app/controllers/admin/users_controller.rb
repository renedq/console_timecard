require 'pry'
require 'date'

module Admin
	class UsersController < ApplicationController
    before_action :verify_admin
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
		end

		def update
			@user = User.find(params[:id])
			@user.update(user_params)
			redirect_to admin_user_path(id: @user.id), notice: "Update successful"
		end
		
		def user_params
			user_details = params.require(:user)
			{
				first_name: user_details['first_name'],
				last_name: user_details['last_name'],
				email: user_details['email'],
				active: user_details['active'],
				admin: user_details['admin']
			}
		end

		private def set_user
			@user = User.find(params[:id])
		end

    private def verify_admin
      unless current_user.admin?
        flash[:alert] = 'You do not have sufficient access to do that action'
        redirect_to root_path
      end
    end
	end
end
