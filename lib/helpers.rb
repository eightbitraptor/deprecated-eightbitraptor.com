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
  end
end
