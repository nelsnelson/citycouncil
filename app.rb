
require 'sinatra'
require 'json'
require 'erubis'
require 'maruku'

$KCODE = 'u' if RUBY_VERSION < '1.9'

# use Rack::Session::Cookie, :key => 'rack.session',
#                            :domain => 'localhost',
#                            :path => '/',
#                            :expire_after => 2592000, # In seconds
#                            :secret => SecureRandom.hex

set :root, File.dirname(__FILE__) + '/app'
set :public_folder, File.dirname(__FILE__) + '/public'
set :markdown, :layout_engine => :maruku, :layout => false

configure(:development) {
  require 'securerandom'
  set :session_secret, SecureRandom.hex
  enable :sessions
}

class Sinatra::Application
end

[ "#{settings.root}/helpers/**/*.{rb}",
  "#{settings.root}/routes/**/*.{rb}",
  "#{settings.root}/models/**/*.{rb}"
].each { |path|
  Dir.glob(path, &method(:require))
}

before do
  content_type :html, 'charset' => 'utf-8'
  request.env['PATH_INFO'].gsub!(/\/$/, '')
end

get /\/([^\/]+)\/?/ do
  resource = "#{params[:captures].first}"
  erb :"/#{verify resource}/index"
end

get /\/?/ do
  erb :"default/index"
end

