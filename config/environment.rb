require 'rubygems'
require 'bundler'

Bundler.require(:default, ENV.fetch('RACK_ENV', :development))

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
