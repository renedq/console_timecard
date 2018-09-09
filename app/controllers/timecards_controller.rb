require 'date'

class TimecardsController < ApplicationController
  before_action :set_timecard, only: [:show, :update, :finish, :destroy]

  def index
  end

  def new
    @timecard = Timecard.new
  end

  def create
    user_id = params[:user_id]
    unit_id = User.find(user_id)[:unit_id]
    t = Timecard.create({user_id: user_id, start_time: Date.strptime(params[:timecard][:start_time], '%m/%d/%Y'), hours: params[:timecard][:hours], unit_id: unit_id } )
    redirect_to admin_user_path(id: params[:user_id])
  end

  def update
    @timecard.update_column(:hours, params['timecard']['hours'])
    redirect_to admin_user_path(id: @timecard.user_id)
  end

  def edit
    @timecard = Timecard.find(params[:id])
  end

  def show 
    @timecard = Timecard.find(params[:id])
  end

  def destroy
    user_id=@timecard.user.id
    @timecard.destroy
    redirect_to admin_user_path(id: @timecard.user_id)
  end

  def start
    user_id = params[:id]
    unit_id = params[:unit_id]
    if Timecard.where(user_id: user_id).where(hours: 0).empty? 
      @timecard = Timecard.create({user_id: params[:id], start_time: Time.now(), hours: 0, unit_id: unit_id })
    end
    redirect_to unit_path unit_id 
  end

  def finish
    elapsed = Time.now - @timecard.start_time
    if elapsed > 5
      @timecard.update(hours: ((Time.now - @timecard.start_time)/1.hours).round(2))
    else
      @timecard.destroy
    end
    redirect_to unit_path @timecard.user.unit.id 
  end 

	private def set_timecard
    @timecard = Timecard.find(params[:id])
  end
end
