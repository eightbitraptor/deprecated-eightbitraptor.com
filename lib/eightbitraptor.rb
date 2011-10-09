require 'sinatra'
require 'net/http'
require 'json'

require File.join(File.dirname(__FILE__), "post.rb")
require File.join(File.dirname(__FILE__), "helpers.rb")


class EightBitRaptor < Sinatra::Base
  set :views, File.join(File.dirname(__FILE__), *%w[.. views])
  set :public, File.dirname(__FILE__) + '/../public'
  set :posts_path, File.dirname(__FILE__) + '/../posts'

  enable :static

  get '/' do
    erb :index, :locals => {:posts => Post.most_recent(3)}
  end

  get '/posts' do
    erb :posts, :locals => {:posts => Post.all}
  end

  get '/posts/:name' do |name|
    post = Post.find(name)
    erb :post, :locals => {:post => post}
  end

  get '/tags/:tag' do |tag|
    erb :categories, :locals => { :posts => Post.find_by_tag(tag)}
  end

  get '/admin' do
    redirect 'http://moe.enixns.com:2083', 301
  end

  get '/feed.xml' do
    builder :feed, :locals => { :posts => Post.all }
  end

end
