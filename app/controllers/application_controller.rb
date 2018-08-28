class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :find_user
	before_action :authenticate_user!

  private

  def find_user
    if ENV['TEST_USER_OVERRIDE']
      current_user ||= User.find_by!(email: ENV['TEST_USER_OVERRIDE'])
    end
  end
end
