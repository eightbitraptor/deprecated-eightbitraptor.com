#\ -p 8765
require 'rubygems'
require 'sinatra'
require 'rack/force_domain'

require 'lib/eightbitraptor'

use Rack::ForceDomain, ENV["DOMAIN"]

application = EightBitRaptor.new
run application
