require 'pry'
require 'date'

class MainController < ApplicationController
  def index
    @users = User.where(unit_id: 1).order(:last_name)
    @date = DateTime.now() 
    @current_month = @date.beginning_of_month
    @current_quarter = @current_month - ((@current_month.month % 3) - 1).month
    @fy = @current_month.beginning_of_year - 3.month
    if @date.month > 9
      @fy += 1.year
    end

    #Timecard.where(user_id: 1).order(start_time: :desc).first
  end

  def show
    @users = User.where(unit_id: 1)
  end
end
