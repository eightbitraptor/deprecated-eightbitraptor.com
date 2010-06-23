require 'sinatra'
require 'haml'

require File.join(File.dirname(__FILE__), "post.rb")
require File.join(File.dirname(__FILE__), "helpers.rb")


class EightBitRaptor < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), *%w[.. views])
  set :public, File.dirname(__FILE__) + '/../public'
  set :posts_path, File.dirname(__FILE__) + '/../posts'

  enable :static

  get '/' do
    haml :index, :locals => {:posts => Post.all}
  end

  get '/posts' do
    redirect '/', 301
  end

  get '/post/:name' do
    post = Post.find(params[:name])
    haml :post, :locals => {:post => post}
  end

  get '/admin' do
    redirect 'http://moe.enixns.com:2083', 301
  end

end
