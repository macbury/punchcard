# frozen_string_literal: true

RACK_ENV = ENV['RACK_ENV'] || 'development'

require 'rubygems'
require 'bundler'
Bundler.require(:default, RACK_ENV)

config_path = Pathname.new(File.expand_path(File.dirname(__FILE__))).join('config')

Config.load_and_set_settings(Config.setting_files(config_path, RACK_ENV))

puts Settings.admin_username

require_relative 'lib/punchcard'

run Punchcard
