require 'bundler'
require './lib/crawler'

Bundler.require

task :default, [:format]  do |t, args|
  args.with_defaults(:format => 'mobi')
  begin
    SiteCraw.new('http://lelivros.red/', args.format).craw!
  rescue SystemExit, Interrupt
    puts "\r Stop cralwer... :)"
  end
end

task :category, [:url, :title, :format] do |t, args|
  args.with_defaults(:format => 'mobi')
  begin
    SiteAreaCraw.new(args[:url], args[:title], format).craw!
  rescue SystemExit, Interrupt
    puts "\r Stop cralwer... :)"
  end
end
