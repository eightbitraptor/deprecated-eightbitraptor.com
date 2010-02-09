require 'sinatra'
require 'redcloth'
require 'pp'

class EightBitRaptor < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), *%w[.. views])
  set :public, File.dirname(__FILE__) + '/../public'
  set :posts_path, File.dirname(__FILE__) + '/../posts'
  
  enable :static  

  def post(name)
    path = File.join(options.posts_path, name)
    config = YAML.load_file("#{path}/meta.yml")
    
    {:body  => RedCloth.new(File.read("#{path}/post.markdown")).to_html,
     :title => config[:title],
     :date  => config[:date] }
  end

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
    redirect 'http://blog.eightbitraptor.com', 301
  end

end
