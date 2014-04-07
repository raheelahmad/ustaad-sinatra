require 'rubygems'
require 'sinatra'

class App < Sinatra::Application
  get '/' do
    return 'Hello'
  end
end
