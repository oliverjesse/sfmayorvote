#!/usr/bin/env ruby

require File.expand_path('../../config/environment',  __FILE__)
require 'twitter'

results = Twitter.search('#sfmayor')

created_count = 0
while results['error'].blank? do
  results['results'].each do |tweet|
    if Tweet.audit(tweet)
      created_count += 1
      print "*"
    else
      print "."
    end
  end
  results = Twitter.next_page(results['next_page'].to_s)
  puts
end

puts "#{created_count} new tweets found"
