# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create 10 Test Boards
10.times {|i| Board.create(name: "Test Board #{i}")}

# Save Random Boards
Board.all.each do |board|
  board.saved_boards << Board.order("RANDOM()").limit(rand(1..4))
end

# Create API Key
key = ApiKey.create

# Publish API Key to the console
puts "=================="
puts "API Key"
puts ""
puts "Key: #{key.key}"
puts "Secret: #{key.secret}"
puts "=================="
