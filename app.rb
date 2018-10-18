require 'nokogiri'
require 'open-uri'
require 'pp'
require 'json'
require 'bundler'
Bundler.require

$:.unshift File.expand_path("../lib/app", __FILE__)
$:.unshift File.expand_path("../db", __FILE__)

require 'townhalls_scrapper.rb'
# require 'townhalls.json'

Scrapper.new.perform