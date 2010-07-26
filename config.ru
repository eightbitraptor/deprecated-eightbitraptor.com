#\ -p 8765
require "rubygems"
require 'lib/eightbitraptor'
#require 'rack-force_domain'

#use Rack::ForceDomain, ENV["DOMAIN"]

application = EightBitRaptor.new
run application
