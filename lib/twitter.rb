require 'uri'
require 'yajl/http_stream'

class Twitter
  MAX_ALLOWED_ERRORS = 1200
  
  def self.filter_stream(username, password, filters = {}, &block)
    url = URI.parse("http://#{username}:#{password}@stream.twitter.com/1/statuses/filter.json")
    params = []
    params << "follow=#{[*filters[:users]].join(",")}" if filters[:users]
    params << "track=#{[*filters[:keywords]].join(",")}" if filters[:keywords]
    params << "locations=#{[*filters[:locations]].join(",")}" if filters[:locations]
    consecutive_errors = 0
    while consecutive_errors < MAX_ALLOWED_ERRORS  do
      begin
        Yajl::HttpStream.post(url, params.join("&"), :symbolize_keys => true) do |status|
          consecutive_errors = 0
          yield(status)
        end
      rescue Yajl::HttpStream::InvalidContentType
        consecutive_errors += 1
      end
      sleep(0.25*consecutive_errors)
    end
  end
  
end