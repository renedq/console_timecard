class Menu < ActiveRecord::Base
    belongs_to :vendor
    has_many :votes
    has_many :comments
end
