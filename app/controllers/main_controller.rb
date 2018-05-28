require 'pry'
require 'date'

class MainController < ApplicationController
  def index
    @users = User.where(unit_id: 1).order(:last_name)

    #Timecard.where(user_id: 1).order(start_time: :desc).first
    #binding.pry
  end

  def show
    @users = User.where(unit_id: 1)
  end
end
