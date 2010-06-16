#\ -p 8765
require "rubygems"
require 'lib/eightbitraptor'

#use Rack::ForceDomain, ENV["DOMAIN"]

application = EightBitRaptor.new
run application
