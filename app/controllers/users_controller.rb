require 'pry'
require 'date'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

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
