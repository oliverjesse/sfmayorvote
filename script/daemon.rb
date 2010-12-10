# ENV_PATH  = File.expand_path('../../config/environment',  __FILE__)
# BOOT_PATH = File.expand_path('../../config/boot',  __FILE__)
# APP_PATH  = File.expand_path('../../config/application',  __FILE__)
# ROOT_PATH = File.expand_path('../..',  __FILE__)

# require 'config/environment'
require File.expand_path('../../config/environment',  __FILE__)
# require 'twitter/json_stream'

require 'tweetstream'
# require 'ruby-growl'
require 'net/http'
require 'uri'
require 'json'
# require 'postgres-pr'
# require 'em_postgresql'

POST_URL = "localhost:3000/vote.json"
server = "localhost"
port = 3000
path = "/vote.json"

if args_start = ARGV.index('--')
  username, password = ARGV[args_start + 1].split(':')
  tracks = (ARGV[args_start + 2 .. -1] + Chain.terms).flatten
  puts "Starting a GrowlTweet to track: #{tracks.inspect}"
end

g = Growl.new 'localhost', 'growltweet', ['tweet'], ['tweet'], 'Owlgray'

TweetStream::Daemon.new(username,password,"tweetstream").track(*tracks) do |status|
  puts status.user.screen_name, status.text
  Chain.terms.select {|term| (Regexp.new(term.split.first) =~ status.text) && (Regexp.new(term.split.last) =~ status.text) }.each do |termpair| 
    puts "Calling increments of interplanetary cruft."
    puts termpair
    conn = EventMachine::Protocols::HttpClient2.connect server, port
    puts "I'd like to make contact with foo."
    query = "termpair=#{CGI.escape(termpair)}&status=#{CGI.escape(status.text)}&screen_name=#{CGI.escape(status.user.screen_name)}"
    # url.query = { :termpair => termpair, :status => status.text, :screen_name => status.user.screen_name }.to_query
    # puts url.query
    # queryformat = { :termpair => termpair, :status => status.text, :screen_name => status.user.screen_name }.to_query
    puts query
    puts "We are your friends."
    url = path + "#" + query
    puts url
    # request = Net::HTTP::Post.new(url.path)
    # request.set_form_data({ :termpair => termpair, :status => status.text, :screen_name => status.user.screen_name }, ';')
    # # TODO: restful xml post error checking would be nice.  what do we do if error or slow?
    # response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
    
    req = conn.post(url)
    req.callback{ |response|
      puts response[:status]
      puts response[:headers]
      puts response[:content]
    }
    
    # http = EventMachine::Protocols::HttpClient2.request(
    #      :host => url.host,
    #      :port => url.port,
    #      :request => url.path,
    #      :query_string => url.query,
    #      :verb => "POST"
    #    )
    #    http.callback {|response|
    #      puts response[:status]
    #      puts response[:headers]
    #      puts response[:content]
    #    }
    
    puts "Completed POST with Response #{response.inspect}"
  end
  # g.notify 'tweet', status.user.screen_name, status.text
end
