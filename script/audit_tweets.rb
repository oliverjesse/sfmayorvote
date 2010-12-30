#!/usr/bin/env ruby

require File.expand_path('../../config/environment',  __FILE__)
require 'twitter'

results = Twitter.search('#sfmayor')

created_count = 0
while results['error'].blank? do
  results['results'].each do |tweet|
    if Tweet.find_by_twitter_id(tweet['id'])
      print "."
    else
      user = Twitter.user(tweet['from_user'])
      voter = Voter.find_or_initialize_by_screen_name(user['screen_name'])
      voter[:profile_image_url] = user['profile_image_url']
      voter[:twitter_id] = user['id']
      voter[:name] = user['name']
      voter.save!
      voter.tweets.create!(
        'twitter_id' => tweet['id'],
        'text' => tweet['text'],
        'tweeted_at' => tweet['created_at']
      )

      created_count += 1
      print "*"
    end
  end
  results = Twitter.next_page(results['next_page'].to_s)
  puts
end

puts "#{created_count} new tweets found"
