class EightBitRaptor < Sinatra::Base
  helpers do
    
    def partial(page, options={})
      haml page, options.merge!( :layout => false )
    end
  
  end
end
