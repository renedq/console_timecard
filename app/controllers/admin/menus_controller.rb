require 'pry'
require 'date'

module Admin
  class MenusController < ApplicationController
    def index
      @menus = Menu.all 
    end

    def new
      @menu = Menu.new
    end

    def show
      @menu = Menu.find(params[:id])
      @votes = @menu.votes.sort_by{|v| v.user.username}
    end

    def edit
      @menu = Menu.find(params[:id])
    end

    def create
      @menu = Menu.new(menu_params)

      if @menu.save
        redirect_to admin_menu_path(id: @menu.id), notice: 'Your menu was successfully created.'
      else
        render :new
      end
    end

    def update
      @menu = Menu.find(params[:id])

      if @menu.update(menu_params)
        redirect_to admin_menu_path(id: @menu.id), notice: 'Your menu was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @menu = Menu.find(params[:id])

      @menu.destroy
      redirect_to admin_menus_path, notice: 'Your menu was successfully destroyed.'
    end

    private

    def verify_admin
      unless @current_user.administrator?
        flash[:alert] = 'You do not have sufficient access to do that action'
        redirect_to root_path
      end
    end

    def set_menu
      @menu = Menu.find(params[:id])
    end

    def menu_params
        menu_details = params.require(:menu)
        {
            vendor_id: menu_details['vendor'],
            menu_date: create_date(menu_details['menu_date']),
            menu_type: menu_details['menu_type'],
            details: menu_details['details']
        }
    end

    def create_date(date)
      begin
        Date.strptime(date, "%m/%d/%Y")
      rescue ArgumentError
        nil
      end
    end
  end
end
