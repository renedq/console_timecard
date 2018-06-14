require 'pry'
require 'date'


module SuperAdmin
	class UsersController < ApplicationController
		before_action :set_user, only: [:show, :update, :edit, ]

		def index
			@users = User.all.order(last_name: :asc)
		end

		def new
			binding.pry
			@user = User.new
		end

		def create
			@user = User.create(user_params)

			if @user.save
				redirect_to super_admin_user_path(id: @user.id), notice: "User successfully created"
			else
				render :new
			end
		end

		def show
		end

		def edit
		end

		def update
			if @user.update(user_params)
				redirect_to super_admin_user_path(id: @user.id), notice: "User successfully updated"
			else
				render :edit
			end
		end
		
		private def set_user
			@user = User.find(params[:id])
		end
		
		private def user_params
			d = params.require(:user)
			{
				first_name: 		d['first_name'],
				last_name:  		d['last_name'],
				email_address:	d['email_address']
			}
		end	
	end
end
