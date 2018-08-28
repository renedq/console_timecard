require 'pry'

class UnitsController < ApplicationController
  before_action :set_unit, only: [:show]

  def index
		#binding.pry
		if current_user.admin?
    	@units = Unit.all.order(:name)
		else
			redirect_to unit_path(current_user.unit_id)
		end
    #@units = Unit.all.order(:name)
  end

  def show
    @users_data = []
    for user in @unit.users.order(:last_name)
      @users_data.append(DisplayTimecards.new(user).call)
    end
  end
	
  private def set_unit
    @unit = Unit.where(id: params[:id]).first
  end
end
