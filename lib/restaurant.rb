R_APP_ROOT = File.dirname(__FILE__)
$:.unshift( File.join(R_APP_ROOT, 'support') )
require 'number_helper'

class Restaurant
  include NumberHelper

  @@filepath = nil
  def self.filepath=(path=nil)  #setter method for accessing the filepath 
    @@filepath = File.join(APP_ROOT, path)
  end
 
=begin
  def self.file
    puts @@filepath
  end 
=end

attr_accessor :name , :cuisine , :price

  
  
  def self.file_exists?
    # class should know if the restaurant file exists
    if @@filepath && File.exists?(@@filepath)
      puts "outputting from file_exists method : True"
      return true
      
    else
      puts "outputting from file_exists method : False"
      return false
      quit
    end
  end
  
  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end
  
  def self.create_file
    # create the restaurant file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?quit
  end
  
  def self.saved_restaurants
    # read the restaurant file
    # return instances of restaurant

    # We have to ask ourselves, do we want a fresh copy each 
    # time or do we want to store the results in a variable?
    restaurants = []
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        restaurants << Restaurant.new.import_line(line.chomp)
      end
      file.close
    end
    return restaurants
  end

  def self.build_using_questions
    args = {}
    print "Restaurant name: "
    args[:name] = gets.chomp.strip

    print "Cuisine type: "
    args[:cuisine] = gets.chomp.strip
    
    print "Average price: "
    args[:price] = gets.chomp.strip
    
    return self.new(args)
  end

  ## instance methods will be here ##

  def initialize(args={})
    @name    = args[:name]    || ""
    @cuisine = args[:cuisine] || ""
    @price   = args[:price]   || ""
  end

  def import_line(line)
    line_array = line.split("\t")
    @name, @cuisine, @price = line_array
    return self
  end

  def save
    return false unless Restaurant.file_usable?
    File.open(@@filepath, 'a') do |file|  #we will append to the end that's why we are adding 'a' mode
      file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
    end
    return true
  end

  def formatted_price
    number_to_currency(@price) #this is a attribute we can call
  end

end

## Testing ##
=begin
Restaurant.file_exists?
value = Restaurant.file_usable?
puts "Output of file_usable mathos is #{value}."
Restaurant.file
=end

