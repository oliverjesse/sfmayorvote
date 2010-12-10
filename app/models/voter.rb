class Voter < ActiveRecord::Base
  has_many :tweets
  validates_uniqueness_of :screen_name
end