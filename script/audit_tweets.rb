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
      if user['error'].present?
        puts "#{user['error']} #{tweet['from_user']}" 
        next
      end
      voter = Voter.find_or_initialize_by_twitter_id(user['id'])
      voter[:profile_image_url] = user['profile_image_url']
      voter[:screen_name] = user['screen_name']
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
