class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_user

  private

  def find_user
    if %w(production uat).include?(ENV["RAILS_ENV"])
      @current_user ||= User.find_by!(username: request.env['HTTP_DRW_SSO_USER'])
#    elsif ENV['TEST_USER_OVERRIDE']
#      @current_user ||= User.find_by!(username: ENV['TEST_USER_OVERRIDE'])
    else
      @current_user ||= User.first # the first user in seeds.rb is an administrator
    end
  end
end
