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
    haml :index, :locals => {:posts => Post.most_recent(2)}
  end

  get '/posts' do
    haml :posts, :locals => {:posts => Post.all}
  end

  get '/posts/:name' do |name|
    post = Post.find(name)
    haml :post, :locals => {:post => post}
  end

  get '/categories/:category' do |category|
    haml :categories, :locals => { :posts => Post.find_by_category(category)}
  end

  get '/admin' do
    redirect 'http://moe.enixns.com:2083', 301
  end

end
