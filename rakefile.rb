require 'bundler'
require './lib/crawler'

Bundler.require

task :default, [:format]  do |t, args|
  args.with_defaults(:format => 'mobi')
  reporter = Reporter.new

  begin
    SiteCraw.new('http://lelivros.red/', args.format, reporter).craw!
  rescue SystemExit, Interrupt
    reporter.stop
  end

  reporter.summary
end

task :category, [:url, :title, :format] do |t, args|
  args.with_defaults(:format => 'mobi')
  reporter = Reporter.new

  begin
    SiteAreaCraw.new(args[:url], args[:title], args[:format]).craw!
  rescue SystemExit, Interrupt
    reporter.stop
  end

  reporter.summary
end

task :clean_broken do
  sh 'rm downloads/broken.yml'
end
