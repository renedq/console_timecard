module Api
  class MattermostController < ActionController::Base

    before_action :find_user, only: [:vote_on_menu, :comment_on_menu]
    before_action :find_menu, only: [:vote_on_menu, :comment_on_menu]

    #def index
    #  @username = params[:username]
    #  @menu = Menu.where("menu_date > ?",Time.now)
    #end
    
    def menu
        @menu = Menu.where(menu_date: Time.now).first
    end

    def vote_on_menu
        Vote.find_or_create_by(menu: @menu, user: @current_user)
        render json: {"ephemeral_text": "Thank you for voting on #{@menu.vendor}"}.to_json
    end

    def comment_on_menu
        Comment.create_by(menu: @menu, user: @current_user)
    end

    private

    def find_user
      @current_user = User.find_by(username: params[:context][:username])
    end

    def find_menu
      @menu = Menu.find(params[:id])
    end
  end
end
