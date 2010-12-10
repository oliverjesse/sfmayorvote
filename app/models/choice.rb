class Choice < ActiveRecord::Base
  belongs_to :chain
  has_many :tweets
  
  def upvote
    update_attribute(:number, number + 1)
  end
  
  class << self
    def for_tweet(tweet)
      Choice.all.each do |c|
        return c if tweet.text =~ /#{c.term}/
      end
      nil
    end
    
  end
  
end