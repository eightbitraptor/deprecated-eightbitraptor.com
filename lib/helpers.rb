require 'uri'
require 'date'
require 'rdiscount'

class EightBitRaptor < Sinatra::Base
  helpers do

    def partial(page, options={})
      erb page, options.merge!( :layout => false )
    end

    def to_html(content)
      RDiscount.new(content).to_html
    end

    def pretty_date(date_in)
      Date.parse(date_in).strftime('%B %d %Y')
    end

    def post_url(post)
      "http://eightbitraptor.com/posts/#{post.printable_pathname}"
    end

    def comment_link_for(post_title)
      "mailto:matt@eightbitraptor.com?subject=" + URI::escape("A Comment about #{post_title}")
    end

  end
end
