class User < ActiveRecord::Base
  has_many :timecards

  def administrator?
    admin
  end
end
