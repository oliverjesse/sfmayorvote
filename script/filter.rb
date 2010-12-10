require 'tweetstream'
require 'postgres-pr'
require 'em_postgresql'
 
USERNAME = "oliverjesse"  # Replace with your Twitter user
PASSWORD = "v1m1LA"  # and your Twitter password
STORE = TweetStore.new
 
TweetStream::Client.new(USERNAME, PASSWORD).track('lol') do |status|
  # Ignore replies. Probably not relevant in your own filter app, but we want
  # to filter out funny tweets that stand on their own, not responses.
  # if status.text !~ /^@\w+/

  # Yes, we could just store the Status object as-is, since it's actually just a
  # subclass of Hash. But Twitter results include lots of fields that we don't
  # care about, so let's keep it simple and efficient for the web app.
  
  
  # needs to be an http request for coming from seedbox to heroku if that's desirable.
  Tweet.create{(
    'id' => status[:id],
    'text' => status.text,
    'username' => status.user.screen_name,
    'userid' => status.user[:id],
    'name' => status.user.name,
    'profile_image_url' => status.user.profile_image_url,
    'received_at' => Time.new.to_i
  )

end