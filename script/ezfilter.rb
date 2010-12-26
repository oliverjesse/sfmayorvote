require File.expand_path('../../config/environment',  __FILE__)
require 'twitter'

USERNAME = "oliverjesse"  # Replace with your Twitter user
PASSWORD = "FivnrQ12"  # and your Twitter password

if args_start = ARGV.index('--')
  USERNAME, PASSWORD = ARGV[args_start + 1].split(':')
  tracks = (ARGV[args_start + 2 .. -1] + Chain.terms).flatten
  Rails.logger.info "Starting a GrowlTweet to track: #{tracks.inspect}"
end

g = Growl.new 'localhost', 'growltweet', ['tweet'], ['tweet'], 'Owlgray'

Twitter.filter_stream(USERNAME, PASSWORD, { :keywords => tracks }) do |status|
  Rails.logger.info "Waking up to smell the Tweet: #{status[:text]}\n"
  voter = Voter.find_or_initialize_by_screen_name(status[:user][:screen_name])
  voter.twitter_id = status[:user][:id]
  voter.name = status[:user][:name]
  voter.profile_image_url = status[:user][:profile_image_url]
  voter.save
  tweet = voter.tweets.build(
    'twitter_id' => status[:id],
    'text' => status[:text]
  )
  tweet.save && (Rails.logger.info "Successfully saved Tweet for user #{status[:user][:screen_name]}\n")
  Rails.root.join('public/index.html').unlink
end
