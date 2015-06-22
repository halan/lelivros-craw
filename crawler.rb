#!/usr/bin/env ruby

require 'bundler'
require 'fileutils'
require './lib/page'
require './lib/books'
require './lib/site_area'
require './lib/site'

Bundler.require

@site = SiteCraw.new('http://lelivros.red/').craw!
