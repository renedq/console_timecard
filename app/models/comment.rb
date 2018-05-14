class Comment < ActiveRecord::Base
    belongs_to :vote
    belongs_to :menu
end
