# Mastermind Game - The Odin TheOdinProject Intermediate Ruby Project 2
module Mastermind

  class Code

    attr_accessor :row, :correct_code, :feedback

    def initialize
      @feedback = {BLACK: 1, WHITE: 1}
      print @feedback
      @correct_code = false
    end

    def create_code (pegs)
      @row = {one: pegs[0], two: pegs[1], three: pegs[2], four: pegs[3]}
    end

    def compare (g_row)
      #paramenter is a hash representing a row.
      puts "Comparing to Master Code ......"

      @row.each do |pos, color|
        puts "Position #{pos} is #{color}"
        if g_row[pos] == color
          puts "Black Peg awrded"
          @feedback.each{|key, value| key == :BLACK ? value += 1 : value}
        elsif g_row.include?(color)
          @feedback.each{|key, value| key == :WHITE ? vlaue += 1 : value}
          puts "White Peg awrded"
        end
      end
      @feedback.each {|key, value| puts "#{key.to_s} pegs: #{value}"}
    end

    def correct_code

    end

  end # Code

  class Code_Master < Code

    def initialize
      create_code
      @feedback = Array.new(4, " ")
      @correct_code = false
    end

    def create_code # overide superclass method
      #Randonly generate a 4 peg code, assign a colour and postion (1 - 4)
      already_used = true
      pegs = Array.new
      pegs << get_color
      count = 0
      3.times do
        count += 1
        while already_used
          new_color = get_color
          pegs.include?(new_color) ? already_used = true : already_used = false
        end
        pegs << new_color
        already_used = true
      end
      @row = {one: pegs[0], two: pegs[1], three: pegs[2], four: pegs[3]}
    end

    def get_color
      col = rand(1..4)
      case col
        when 1
          "Red"
        when 2
          "Blue"
        when 3
          "Green"
        else
          "Yellow"
        end
      end

      private :create_code, :get_color
  end # Code
end #Mastermind
