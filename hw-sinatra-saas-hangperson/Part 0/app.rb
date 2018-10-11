require 'sinatra'

class App < Sinatra::Base
  get '/' do
    'Goodbye, World!'
  end
end
