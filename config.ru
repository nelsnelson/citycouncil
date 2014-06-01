
require 'rubygems'
require 'sinatra'
require 'app'

configure do
  enable :logging, :sessions, :static
  set :environment, :production
end

deploy_dir = File.expand_path(File.dirname(__FILE__))
log_dir = "#{deploy_dir}/log"
FileUtils.mkdir_p log_dir unless File.exists?(log_dir)
log = File.new(ENV['APP_LOG'] || "#{log_dir}/citycouncil.log", 'a+')
puts "Log file is #{log.path}"
#STDOUT.reopen(log)
#STDERR.reopen(log)
Sinatra::Application.use Rack::ShowExceptions
Sinatra::Application.use Rack::CommonLogger, log

run Sinatra::Application

