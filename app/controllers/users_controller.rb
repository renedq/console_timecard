require 'pry'
require 'date'

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
    for timecard in @user.timecards.order(start_time: :desc) do
      hours = 0
      if timecard.end_time
        hours = ((timecard.end_time - timecard.start_time)/(60*60)).round(2)
      end
      record = {"start_time": timecard.start_time, "hours": hours, "id": timecard.id}
      timecards.append(record)
    end
    @timecards = timecards
  end

  def edit
    binding.pass
    pass
  end
  
  private def set_user
    @user = User.find(params[:id])
  end
end
