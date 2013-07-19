# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'

if development?
  require 'sinatra/reloader'
  require 'debugger'
end 


require 'erb'
require 'dropbox_sdk'
require 'gon-sinatra'

Sinatra::register Gon::Sinatra

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

set :root, APP_ROOT

# Set up the controllers and helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Get your app key and secret from the Dropbox developer website
APP_KEY = ENV['APP_KEY']
APP_SECRET = ENV['APP_SECRET']

# ACCESS_TYPE should be ':dropbox' or ':app_folder' as configured for your app
ACCESS_TYPE = :dropbox
