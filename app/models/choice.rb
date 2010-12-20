class Choice < ActiveRecord::Base
  belongs_to :chain
  has_many :tweets
  has_many :voters, :through => :tweets, :select => "DISTINCT voters.*"

  def name
    label
  end

  def handle
    term.split.first
  end
  
  def image_url
    "/images/politician-" + name.split.last.downcase + ".jpg"
  end
  
  def upvote
    update_attribute(:number, number + 1)
  end
  
  def calculate_percentage
    return 0 unless (self.chain.number > 0)
    (number / self.chain.number.to_f).round(2)
  end
  

  
  class << self
    # def for_tweet(tweet)
    #   Choice.all.each do |c|
    #     return c if tweet.text =~ /#{c.term}/i
    #   end
    #   nil
    # end
    
    # must have ANY words from term in any order
    def for_tweet(tweet)
      Choice.all.each do |c|
        words = c.term.split
        found = false
        words.each do |w|
          found = (found || (tweet.text =~ /#{w}/i))
        end
        return c if found
      end
      nil
    end
    
  end
  
end