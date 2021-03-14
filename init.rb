#### Food Finder ####
#
# Launch this Ruby file from the command line 
# to get started.
#

APP_ROOT = File.dirname(__FILE__)
#puts "app root of init #{APP_ROOT}"
# require "#{APP_ROOT}/lib/guide"
# require File.join(APP_ROOT, 'lib', 'guide.rb')
# require File.join(APP_ROOT, 'lib', 'guide')

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'guide'

guide = Guide.new('restaurants.txt')  #bring up a new guide instance & get started
guide.launch!
