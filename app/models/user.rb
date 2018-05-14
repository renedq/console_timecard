class User < ActiveRecord::Base
  has_many :votes
  has_many :comments, through: :votes

  def administrator?
    admin
  end
end
