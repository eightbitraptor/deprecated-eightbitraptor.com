#\ -p 8765
require 'bundler/setup'
require File.expand_path('../lib/eightbitraptor.rb', __FILE__)
require 'rack-force_domain'

use Rack::ForceDomain, ENV["DOMAIN"]

application = EightBitRaptor.new
run application
