require 'pry'

module Admin
  class VendorsController < ApplicationController
    def index
      @vendors = Vendor.all.order(name: :asc)
    end

    def new
      @vendor = Vendor.new
    end

    def show
      @vendor = Vendor.find(params[:id])
      @menus = @vendor.menus.where('menu_date <= ?', DateTime.now).order(menu_date: :asc)
    end

    def edit
        @vendor = Vendor.find(params[:id])
    end

    def create
      @vendor = Vendor.new(vendor_params)

      if @vendor.save
        redirect_to admin_vendor_path(id: @vendor.id), notice: 'Your vendor was successfully created.'
      else
        render :new
      end
    end

    def update
      @vendor = Vendor.find(params[:id])

      if @vendor.update(vendor_params)
        redirect_to admin_vendor_path(id: @vendor.id), notice: 'Your vendor was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @vendor = Vendor.find(params[:id])

      @vendor.destroy
      redirect_to admin_vendors_path, notice: 'Your vendor was successfully destroyed.'
    end

    private

    def verify_admin
      unless @current_user.administrator?
        flash[:alert] = 'You do not have sufficient access to do that action'
        redirect_to root_path
      end
    end

    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    def vendor_params
        vendor_details = params.require(:vendor)
        {
            name: vendor_details['name'],
            location: vendor_details['location'],
            image: vendor_details['image']
        }
    end

    def create_datetime(date, time)
      begin
        Time.strptime("#{date} #{time}", '%m/%d/%Y %I:%M %p')
      rescue ArgumentError
        nil
      end
    end
  end
end
