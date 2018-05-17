require 'pry'
require 'date'

class MainController < ApplicationController
  def index
    binding.pry
    @users = User.where(unit_id: 1)
  end

  def show
    @users = User.where(unit_id: 1)
  end
end
