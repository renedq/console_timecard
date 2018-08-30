module Admin
  class AdminController < ApplicationController
    before_action :verify_admin

    #todo: do we need this controller?
    def index
      binding.pry
    end

    private def verify_admin
      unless current_user.admin?
        flash[:alert] = 'You do not have sufficient access to do that action'
        redirect_to root_path
      end
    end
  end
end
