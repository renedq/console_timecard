class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_user

  private

  def find_user
    if ENV['TEST_USER_OVERRIDE']
      @current_user ||= User.find_by!(email_address: ENV['TEST_USER_OVERRIDE'])
    else
      @current_user ||= User.first # the first user in seeds.rb is an administrator
    end
  end
end
