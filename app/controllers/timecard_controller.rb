require 'pry'
require 'date'

class TimecardController < ApplicationController
  def index
    @timecards = Timecard.all
  end

  def start
    @timecard = Timecard.create({user_id: params[:user_id], start_time: Time.now()})
    binding.pry
  end

  def finish
    binding.pry
    @timecard = Timecard.find({user_id: params[:id]})
  end
end
