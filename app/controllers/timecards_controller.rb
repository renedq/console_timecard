require 'date'

class TimecardsController < ApplicationController
  before_action :set_timecard, only: [:show, :update, :finish, :destroy]

  def index
    @unit = Unit.find(current_user.unit_id)
    @users_data = []

    if not params[:FY].nil? 
      @fy = Time.new(params[:FY])
    else
      @fy = Time.now
      if @fy.month > 9
        @fy += 1.year
      end
      @fy = @fy.beginning_of_year
    end
    @earlier = false
    @later = false
    if Timecard.where("start_time < ?", @fy).size > 0
      @earlier = true
    end
    if Timecard.where("start_time > ?", (@fy + 1.year - 1.day)).size > 0
      @later = true
    end
    for user in @unit.users.where(active: true).order(:last_name)
      @users_data.append(DisplayTimecards.new(user, @fy).call)
    end
  end

  def new
		@user_id = params[:id]
    @timecard = Timecard.new
  end

  def create
    user_id = params[:user_id]
    unit_id = User.find(user_id)[:unit_id]
		start_time = create_start_time(params[:start_date], params[:start_time])
    @timecard =  Timecard.new({user_id: user_id, start_time: start_time, hours: params[:timecard][:hours], unit_id: unit_id } )
    if @timecard.save
      redirect_to admin_user_path(id: params[:user_id]), notice: "Your timecard was created successfully"
    else
			@user_id = user_id
      render :new
    end
  end

  def update
		@timecard = Timecard.find(params[:id])
    if @timecard.update(hours: params['timecard']['hours'])
			redirect_to admin_user_path(id: @timecard.user_id), notice: "Your timecard was updated successfully"
		else
			render :edit
		end
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
    if not Timecard.where(user_id: @timecard.user.id).where(hours: 0).empty? 
			elapsed = Time.now - @timecard.start_time
			if elapsed > 18 
				@timecard.update(hours: ((Time.now - @timecard.start_time)/1.hours).round(2))
			else
				@timecard.destroy
			end
		end
    redirect_to unit_path @timecard.user.unit.id 
  end 

	private 
	
	def set_timecard
    @timecard = Timecard.find(params[:id])
  end

	def create_start_time(date, time)
		begin
			Time.strptime("#{date} #{time}", '%m/%d/%Y %I:%M %p')
		rescue ArgumentError
			nil
		end
	end
end
