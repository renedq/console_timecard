module Admin
	class UnitsController < ApplicationController
		before_action :verify_admin
                before_action :verify_super_admin, only: [:index, :new, :create]
		before_action :set_unit, only: [:show, :edit, :update]

		def index
                  @units = Unit.all.order(:name)
		end

		def new
			@unit = Unit.new
		end

		def create
			@unit = Unit.new(unit_params)

			if @unit.save
				redirect_to admin_units_path, notice: 'Unit successfully created'
			else
				render :new
			end
		end

		def update
			if @unit.update(unit_params)
				redirect_to admin_units_path, notice: 'Unit successfully updated'
			else
				render :edit
			end
		end

		def show
                  @users_data = []
                  for user in @unit.users.order(:last_name)
                    @users_data.append(DisplayTimecards.new(user).call)
                  end
		end
		
		private def set_unit
		  @unit = Unit.find(params[:id])
		end

		private def unit_params
			d = params.require(:unit)
			{
				name: d['name'],
				city: d['city'],
				state: d['state'],
				phone_number: d['phone_number']
			}
		end

    private def verify_super_admin
      unless current_user.super_admin?
        flash[:alert] = 'You do not have sufficient access to do that action'
        redirect_to root_path
      end
    end

    private def verify_admin
      unless current_user.admin?
        flash[:alert] = 'You do not have sufficient access to do that action'
        redirect_to root_path
      end
    end
  end
end
