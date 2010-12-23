class GenerateVotesForTweets < ActiveRecord::Migration
  def self.up
    initial_count = Vote.count
    Voter.find_each do |voter|
      latest_tweet = voter.tweets.votable.order('created_at DESC').first
      latest_tweet.try(:score)
      print '.'
    end
    puts "#{Vote.count - initial_count} votes created from tweets"
  end

  def self.down
    Vote.delete_all
  end
end
