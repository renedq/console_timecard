require 'pry'
require 'date'

class TimecardController < ApplicationController
  def index
    @timecards = Timecard.all
  end

  def start
    @timecard = Timecard.create({user_id: params[:id], start_time: Time.now()})
    binding.pry
  end

  def finish
    Timecard.update(params[:id], {:end_time => Time.now})
    #redirect_back(fallback_location: fallback_location)
  end
end
