testdir = File.dirname(__FILE__)
$LOAD_PATH.unshift testdir unless $LOAD_PATH.include?(testdir)

libdir = File.dirname(File.dirname(__FILE__)) + '/lib'
$LOAD_PATH.unshift libdir unless $LOAD_PATH.include?(libdir)

require "rubygems"
require "active_model_secure_token"
require "active_record"
require "mongoid"
require "minitest/autorun"
require "minitest/unit"

ENV['MONGOID_ENV'] = 'test'
Mongoid.load!('./config/mongoid.yml')

Dir["models/*.rb"].each {|file| require file }

ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => ":memory:"

load './config/schema.rb'
