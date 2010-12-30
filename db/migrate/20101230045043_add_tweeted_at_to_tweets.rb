class AddTweetedAtToTweets < ActiveRecord::Migration
  def self.up
    add_column :tweets, :tweeted_at, :datetime
    require 'twitter'

    results = Twitter.search('#sfmayor')

    created_count = 0
    while results['error'].blank? do
      results['results'].each do |tweet|
        if found_tweet = Tweet.find_by_twitter_id(tweet['id'])
          found_tweet.update_attributes(
            'tweeted_at' => tweet['created_at']
          )

          print "."
        else
          user = Twitter.user(tweet['from_user'])
          voter = Voter.find_or_initialize_by_screen_name(user['screen_name'])
          voter[:profile_image_url] = user['profile_image_url']
          voter[:twitter_id] = user['id']
          voter[:name] = user['name']
          voter.save!
          tweet = voter.tweets.build(
            'twitter_id' => tweet['id'],
            'text' => tweet['text'],
            'tweeted_at' => tweet['created_at']
          )
          tweet.save!

          created_count += 1
          print "*"
        end
      end
      results = Twitter.next_page(results['next_page'].to_s)
      puts
    end

    puts "#{created_count} new tweets found"

    Tweet.where(:tweeted_at => nil).find_each do |tweet|
      tweet.update_attributes(:tweeted_at => tweet.created_at)
    end
  end

  def self.down
    remove_column :tweets, :tweeted_at
  end
end
