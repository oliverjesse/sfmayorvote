#!/usr/bin/env ruby

require File.expand_path('../../config/environment',  __FILE__)
require 'twitter'

results = Twitter.search('#sfmayor')

created_count = 0

results['results'].each do |tweet|
  if Tweet.find_by_twitter_id(tweet['id'])
    print '.'
    next
  end

  user = Twitter.user(tweet['from_user'])

  voter = Voter.find_or_initialize_by_screen_name(user['screen_name'])
  voter[:profile_image_url] = user['profile_image_url']
  voter[:twitter_id] = user['id']
  voter[:name] = user['name']
  voter.save!
  tweet = voter.tweets.build(
    'twitter_id' => tweet['id'],
    'text' => tweet['text']
  )
  tweet.save!
  created_count += 1
  print '*'
end

puts

puts "#{created_count} new tweets found"
