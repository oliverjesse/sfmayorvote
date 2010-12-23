class Voter < ActiveRecord::Base
  has_many :tweets, :inverse_of => :voter
  validates :screen_name, :uniqueness => true
  validates :twitter_id, :uniqueness => true
  
end