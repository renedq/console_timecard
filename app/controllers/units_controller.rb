require 'pry'

class UnitsController < ApplicationController
  before_action :set_unit, only: [:show]

  def index
    if current_user.super_admin?
      @units = Unit.all.order(:name)
    else
      redirect_to unit_path(current_user.unit_id)
    end
  end

  def show
    @users_data = []
		binding.pry
    for user in @unit.users.where(active: true).order(:last_name)
      @users_data.append(DisplayTimecards.new(user).call)
    end
  end
	
  private def set_unit
    @unit = Unit.where(id: params[:id]).first
  end
end
