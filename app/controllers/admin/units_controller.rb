require 'pry'

module Admin
	class UnitsController < ApplicationController
		before_action :verify_admin
		before_action :set_unit, only: [:show, :edit, :update]

		def index
                  binding.pry
                  @units = Unit.find(current_user.unit_id)
		end

		def show
                  @users_data = []
                  for user in @unit.users.order(:last_name)
                    @users_data.append(DisplayTimecards.new(user).call)
                  end
		end
		
		def edit

		end

		def update
			if @unit.update(unit_params)
				redirect_to admin_unit_path(id: @unit.id), notice: 'Unit successfully updated'
			else
				render :edit
			end
		end

		private def set_unit
		  @unit = Unit.find(params[:id])
		end

		private def unit_params
			d = params.require(:unit)
			{
				name: d['name']
			}
		end

    private def verify_admin
      unless current_user.admin?
        flash[:alert] = 'You do not have sufficient access to do that action'
        redirect_to root_path
      end
    end
  end
end
