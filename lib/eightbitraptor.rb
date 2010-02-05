require 'sinatra'

class EightBitRaptor < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), *%w[.. views])
  set :public, File.dirname(__FILE__) + '/../public'
  enable :static  

  # 
  # Here lieth controller actions, may they REST in peace
  #
  get '/' do
    erb :index
  end

  get '/admin' do
    redirect 'http://moe.enixns.com:2083', 301
  end
  
  get '/writing' do
    'some list of categories or posts or something'
  end
  
  get '/writing/:id' do
    if params[:id] == ""
      'gah'
    else
      'Nothing here yet '
    end
  end

end
