#!/usr/bin/env ruby

require 'bundler'
require './lib/crawler'

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
