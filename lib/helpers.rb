require 'date'
require 'RedCloth'

class EightBitRaptor < Sinatra::Base
  helpers do

    def partial(page, options={})
      erb page, options.merge!( :layout => false )
    end

    def to_html(content)
      RedCloth.new(content).to_html
    end

    def pretty_date(date_in)
      Date.parse(date_in).strftime('%B %d %Y')
    end

    def post_url(post)
      "http://eightbitraptor.com/posts/#{post.printable_pathname}"
    end

    def get_latest_tweet
      tweet = "Development Mode"
      if ENV['DOMAIN']
        response = Net::HTTP.get(URI.parse("http://api.twitter.com/1/statuses/user_timeline.json?screen_name=shadowaspect"))
        stream = JSON.parse(response)
        tweet = stream[0]["text"]
      end
      erb :tweet, :locals => {:tweet => tweet}, :layout => false
    end
  end
end
