require 'pry'
require 'date'

class UserController < ApplicationController
  def index
    @users = Users.all.order(last_name: :asc)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
end
