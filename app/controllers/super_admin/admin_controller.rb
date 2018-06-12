module Admin
	class AdminController < ApplicationController
		before_action :verify_super_admin

		def index

		end

		private def verify_super_admin
      unless @current_user.super_admin?
        flash[:alert] = 'You do not have sufficient access to do that action'
        redirect_to root_path
      end
    end
	end
end
