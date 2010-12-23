class Choice < ActiveRecord::Base
  belongs_to :chain, :inverse_of => :choices
  has_many :tweets, :inverse_of => :choice

  has_many :votes, :inverse_of => :choice
  has_many :voters, :through => :votes

  scope :by_votes, order("votes_count desc")

  def name
    label
  end

  def handle
    term.split.first
  end

  def calculate_percentage
    return 0 if chain(true).votes_count == 0
    votes_count / chain.votes_count.to_f
  end

  class << self
    # must have ANY words from term in any order
    def for_tweet(tweet)
      Choice.find_each do |c|
        return c if c.term.split.any? {|word| tweet.text =~ /#{word}/i }
      end
      nil
    end
  end
  
end