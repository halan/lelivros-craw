#!/usr/bin/env ruby

require 'bundler'
require 'fileutils'
require './lib/page'
require './lib/books'
require './lib/site_area'
require './lib/site'
require './lib/title_book'

Bundler.require

task :default do
  SiteCraw.new('http://lelivros.red/').craw!
end

task :category, [:url, :title] do |t, args|
  SiteAreaCraw.new(args[:url], args[:title]).craw!
end
