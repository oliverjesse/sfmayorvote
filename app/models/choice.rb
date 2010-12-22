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

  def calculate_percentage
    return 0 unless (self.chain.number > 0)
    (number / self.chain.number.to_f).round(2)
  end

  class << self
    # must have ANY words from term in any order
    def for_tweet(tweet)
      Choice.find_each do |c|
        return c if c.term.split.any? {|word| tweet.text =~ /#{word}/i }
      end
      nil
    end
    
    def for_chain(chain)
      chain.choices.order("number desc")
    end
  end
  
end