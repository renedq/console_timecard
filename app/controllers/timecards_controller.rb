require 'pry'
require 'date'

class TimecardsController < ApplicationController
  before_action :set_timecard, only: [:show, :update, :finish]

  def index
    @timecards = Timecard.all
  end

  def create
    binding.pry
    Timecard.create({user_id: params[:user_id], start_time: params[:start_time], hours: params[:hours] } )
  end

  def update
    binding.pry
    @timecard.update_column(:hours, params[:hours])
  end

  def edit
    @timecard = Timecard.find(params[:id])
    binding.pry
  end

  def delete
    @timecard.destroy
    binding.pry
    #Timecard.destroy(params[:id])
  end

  def start
    #binding.pry
    @timecard = Timecard.create({user_id: params[:id], start_time: Time.now(), hours: 0 })
    redirect_to main_index_path 
  end

  def finish
    binding.pry
    @timecard.update(hours: ((Time.now - @timecard.start_time)/1.hours).round(2))
    redirect_to main_index_path 
  end

  private def set_timecard
    @timecard = Timecard.find(params[:id])
  end
end
