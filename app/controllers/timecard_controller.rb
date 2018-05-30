require 'pry'
require 'date'

class TimecardController < ApplicationController
  def index
    @timecards = Timecard.all
  end

  def start
    @timecard = Timecard.create({user_id: params[:id], start_time: Time.now()})
    redirect_to main_index_path 
  end

  def finish
    Timecard.update(params[:id], {:end_time => Time.now})
    redirect_to main_index_path 
  end
end
