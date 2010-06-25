class EightBitRaptor < Sinatra::Base
  helpers do

    def partial(page, options={})
      haml page, options.merge!( :layout => false )
    end

    def to_html(content)
      Maruku.new(content).to_html
    end
  
  end
end
