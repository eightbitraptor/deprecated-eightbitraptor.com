#\ -p 8765
require 'rubygems'
require 'sinatra'

require 'lib/eightbitraptor'

application = EightBitRaptor.new
run application