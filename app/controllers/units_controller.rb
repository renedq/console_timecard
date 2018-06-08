require 'pry'
require 'date'

class MainController < ApplicationController
  before_action :set_unit, only: [:index, :show]

  def index
    binding.pry
    @users_data = []
    for user in @users
      @users_data.append(DisplayTimecards.new(user).call)
    end
  end

  def show
    @users = Unit.where(unit_id: 1)
  end
	
  def edit 
    @users = Unit.where(unit_id: 1)
  end
	
  def new 
    @users = Unit.where(unit_id: 1)
  end
	
  private def set_unit
    @users = Unit.where(unit_id: params[:id]).order(:last_name)
  end
end
