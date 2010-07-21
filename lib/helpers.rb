require 'date'

class EightBitRaptor < Sinatra::Base
  helpers do

    def partial(page, options={})
      erb page, options.merge!( :layout => false )
    end

    def to_html(content)
      Maruku.new(content).to_html
    end
    
    def pretty_date(date_in)
      Date.parse(date_in).strftime('%B %d %Y')
    end
  
  end
end
