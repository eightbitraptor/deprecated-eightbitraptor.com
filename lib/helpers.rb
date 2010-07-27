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
      response = Net::HTTP.get(URI.parse("http://api.twitter.com/1/statuses/user_timeline.json?screen_name=shadowaspect"))
      stream = JSON.parse(response)
      stream[0]["text"].gsub!(/\b((https?:\/\/)([A-Za-z0-9\-_=%&@\?\.\/]+))\b/){
        "<a href=\"#{$1}\">#{$1}</a>"
      }
      erb :tweet, :locals => {:tweet => stream[0]}, :layout => false
    end
  end
end
