require File.expand_path('../../config/environment',  __FILE__)
require 'twitter'

USERNAME = "oliverjesse"  # Replace with your Twitter user
PASSWORD = "FivnrQ12"  # and your Twitter password

if args_start = ARGV.index('--')
  USERNAME, PASSWORD = ARGV[args_start + 1].split(':')
  tracks = (ARGV[args_start + 2 .. -1] + Chain.terms).flatten
  puts "Starting a GrowlTweet to track: #{tracks.inspect}"
end

g = Growl.new 'localhost', 'growltweet', ['tweet'], ['tweet'], 'Owlgray'

Twitter.filter_stream(USERNAME, PASSWORD, { :keywords => tracks }) do |status|
  v = Voter.find_or_initialize_by_screen_name(status[:user][:screen_name])
  v.twitter_id = status[:user][:id]
  v.name = status[:user][:name]
  v.profile_image_url = status[:user][:profile_image_url]
  v.save
  t = Tweet.new(
    'twitter_id' => status[:id],
    'text' => status[:text],
    :voter => v
  )
  t.save
end