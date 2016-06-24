require "rubygems"
require "bundler"
require "sinatra"

Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems
