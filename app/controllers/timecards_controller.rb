require 'pry'
require 'date'

class TimecardsController < ApplicationController
  before_action :set_timecard, only: [:show, :edit]

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

  def edit
    binding.pry
  end

  def delete
    @timecard.destroy
    binding.pry
    #Timecard.destroy(params[:id])
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

  private def set_timecard
    @timecard = Timecard.find(params[:id])
  end
end
