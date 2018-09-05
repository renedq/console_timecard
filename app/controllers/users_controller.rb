require 'date'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def index
    @Users = User.where(unit_id: params['unit_id']).order(last_name: :asc)
		respond_to do |format|
			format.html
			format.xlsx
		end
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
  
  private def set_user
    @user = User.find(params[:id])
  end
end
