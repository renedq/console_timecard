class User < ActiveRecord::Base
  belongs_to :unit
  has_many :timecards
end
