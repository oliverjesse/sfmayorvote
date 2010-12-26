require 'uri'
require 'yajl/http_stream'

require 'json'
require 'cgi'
require 'patron'

class Twitter
  MAX_ALLOWED_ERRORS = 1200

  class << self
    def filter_stream(username, password, filters = {}, &block)
      url = URI.parse("http://#{username}:#{password}@stream.twitter.com/1/statuses/filter.json")
      params = []
      params << "follow=#{[*filters[:users]].join(",")}" if filters[:users]
      params << "track=#{[*filters[:keywords]].join(",")}" if filters[:keywords]
      params << "locations=#{[*filters[:locations]].join(",")}" if filters[:locations]
      consecutive_errors = 0
      Rails.logger.info "Listening to stream: #{url}, #{params}"
      begin
        Yajl::HttpStream.post(url, params.join("&"), :symbolize_keys => true) do |status|
          consecutive_errors = 0
          yield(status)
        end
      rescue Yajl::HttpStream::InvalidContentType
        Rails.logger.info "Stream Listener hit an error! [#{consecutive_errors}]\n"
        consecutive_errors += 1
        if consecutive_errors < MAX_ALLOWED_ERRORS
          sleep(0.25*consecutive_errors)
          retry
        end
      end
    end

    def search(query)
      request("http://search.twitter.com/search.json?q=#{CGI.escape(query)}&show_user=true")
    end

    def user(screen_name)
      request("http://api.twitter.com/1/users/show.json?screen_name=#{screen_name}")
    end

    def request(url)
      consecutive_errors = 0
      begin
        sess = Patron::Session.new
        sess.connect_timeout = 30
        sess.timeout = 30
        JSON.parse(sess.get(url).body)
      rescue Patron::ConnectionFailed
        consecutive_errors += 1
        if consecutive_errors > MAX_ALLOWED_ERRORS
          raise
        end
        sleep(0.25*consecutive_errors)
        retry
      end
    end
  end
end