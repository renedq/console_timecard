require 'pry'
require 'date'

class TimecardsController < ApplicationController
  before_action :set_timecard, only: [:show, :update, :finish, :destroy]

  def index
    @timecards = Timecard.all
  end

  def create
    binding.pry
    Timecard.create({user_id: params[:user_id], start_time: params[:start_time], hours: params[:hours] } )
  end

  def update
		@timecard.update_column(:hours, params['timecard']['hours'])
		render :show
  end

  def edit
    @timecard = Timecard.find(params[:id])
  end

  def destroy
		user_id=@timecard.user.id
		@timecard.destroy
		redirect_to user_path user_id
  end

  def start
    @timecard = Timecard.create({user_id: params[:id], start_time: Time.now(), hours: 0 })
    redirect_to main_index_path 
  end

  def finish
    @timecard.update(hours: ((Time.now - @timecard.start_time)/1.hours).round(2))
    redirect_to main_index_path 
  end

  private def set_timecard
    @timecard = Timecard.find(params[:id])
  end
end
