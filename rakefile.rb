#!/usr/bin/env ruby

require 'bundler'
require 'fileutils'
require './lib/page_craw'
require './lib/books_craw'
require './lib/site_area_craw'
require './lib/site_craw'
require './lib/title_book'

Bundler.require

task :default do
  begin
    SiteCraw.new('http://lelivros.red/').craw!
  rescue SystemExit, Interrupt
    puts "\r Stop cralwer... :)"
  end
end

task :category, [:url, :title] do |t, args|
  begin
    SiteAreaCraw.new(args[:url], args[:title]).craw!
  rescue SystemExit, Interrupt
    puts "\r Stop cralwer... :)"
  end
end
