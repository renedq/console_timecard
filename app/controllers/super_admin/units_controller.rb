require 'pry'

module SuperAdmin
	class UnitsController < ApplicationController
		before_action :verify_super_admin
		before_action :set_unit, only: [:show, :edit, :update]

		def index
			@units = Unit.all.order(:name)
		end

		def new
			@unit = Unit.new
		end

		def show

		end
		
		def edit

		end

		def create
			@unit = Unit.new(unit_params)

			if @unit.save
				redirect_to super_admin_unit_path(id: @unit.id), notice: 'Unit successfully created'
			else
				render :new
			end
		end

		def update
			if @unit.update(unit_params)
				redirect_to super_admin_unit_path(id: @unit.id), notice: 'Unit successfully updated'
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

	end
end
