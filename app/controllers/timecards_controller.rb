require 'pry'
require 'date'

class TimecardController < ApplicationController
  def index
    @timecards = Timecard.all
  end

  def create
    binding.pry
    Timecard.create({user_id: params[:user_id], start_time: params[:start_time], end_time: (params[:start_time] + (params[:hours]).hours) } )
  end

  def update
    binding.pry
    t = Timecard.find(params[:id])
    t.update_column(:end_time, t.start_time + (params[:hours]).hours)
  end

  def delete
    Timecard.destroy(params[:id])
  end

  def start
    #binding.pry
    @timecard = Timecard.create({user_id: params[:id], start_time: Time.now()})
    redirect_to main_index_path 
  end

  def finish
    #binding.pry
    Timecard.update(params[:id], {:end_time => Time.now})
    redirect_to main_index_path 
  end
end
