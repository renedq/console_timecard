require 'pry'
require 'date'

class MainController < ApplicationController
  def index
    @users = User.where(unit_id: 1).order(:last_name)
    @users_data = []
    for user in @users
      @users_data.append(DisplayTimecards.new(user).call)
    end
  end

  def show
    @users = User.where(unit_id: 1)
  end
end
