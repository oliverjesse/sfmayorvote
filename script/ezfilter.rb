require File.expand_path('../../config/environment',  __FILE__)
require 'twitter'

USERNAME = "oliverjesse"  # Replace with your Twitter user
PASSWORD = "FivnrQ12"  # and your Twitter password

begin
  if args_start = ARGV.index('--')
    USERNAME, PASSWORD = ARGV[args_start + 1].split(':')
    tracks = (ARGV[args_start + 2 .. -1] + Chain.terms).flatten
    Rails.logger.info "Starting a GrowlTweet to track: #{tracks.inspect}"
  end

  g = Growl.new 'localhost', 'growltweet', ['tweet'], ['tweet'], 'Owlgray'

  Twitter.filter_stream(USERNAME, PASSWORD, { :keywords => tracks }) do |status|
    begin
      Rails.logger.info "Waking up to smell the Tweet: #{status[:text]}\n"
      voter = Voter.find_or_initialize_by_twitter_id(status[:user][:id])
      voter.attributes = status[:user].slice(:name, :screen_name, :profile_image_url)
      voter.save
      tweet = voter.tweets.build(
        'twitter_id' => status[:id],
        'text' => status[:text],
        'tweeted_at' => status[:created_at]
      )
      tweet.save && (Rails.logger.info "Successfully saved Tweet for user #{status[:user][:screen_name]}\n")

      cached_index = Rails.root.join('public/index.html')
      cached_index.unlink if cached_index.file?
    rescue Exception => e
      HoptoadNotifier.notify(e)
      puts "Skipping status #{status.inspect} which failed with #{e.inspect}, #{e.message}"
      puts e.backtrace
    end
  end
rescue Exception => e
  HoptoadNotifier.notify(e)
  raise
end
