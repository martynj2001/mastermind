# Mastermind Game play

require "./mastermind.rb"
include Mastermind

puts "*********************"
puts "*********************"
puts "**     Martyn J    **"
puts "**    Mastermind   **"
puts "*********************"
puts "*********************"

master_code = Code_Master.new
p master_code.row
puts "Master Code has been generated - try to guess it in 12 turns!"
turn = 0
while turn < 12
  code = Code.new
  pegs = []
  4.times do |g|
    print "Guess peg #{g} colour (Red, Green, Blue or Yellow): "
    pegs << gets.chomp
    Code.create_code(pegs)
  end
  p code.row
end
