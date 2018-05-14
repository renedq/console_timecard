class Vote < ActiveRecord::Base
    belongs_to :menu
    belongs_to :user
    has_many :comments
end
