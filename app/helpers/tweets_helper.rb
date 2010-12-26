module TweetsHelper
  def tweet_url(screen_name, twitter_id)
    "http://twitter.com/#!/#{screen_name}/status/#{twitter_id}"
  end
end
