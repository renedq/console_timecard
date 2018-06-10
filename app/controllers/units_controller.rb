require 'pry'

class UnitsController < ApplicationController
  before_action :set_unit, only: [:show]

  def index
    @units = Unit.all.order(:name)
  end

  def show
    @users_data = []
    for user in @unit.users.order(:last_name)
      @users_data.append(DisplayTimecards.new(user).call)
    end
  end
	
  def edit 
    @unit = Unit.where(unit_id: 1)
  end
	
  def new 
    @unit = Unit.where(unit_id: 1)
  end
	
  private def set_unit
    @unit = Unit.where(id: params[:id]).first
  end
end
