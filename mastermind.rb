# Mastermind Game - The Odin TheOdinProject Intermediate Ruby Project 2
module Mastermind

  class Code

    attr_accessor :row, :correct_code, :black, :white

    def initialize
      @black = 0
      @white = 0
      @correct_code = false
    end

    def create_code (pegs)
      @row = {one: pegs[0], two: pegs[1], three: pegs[2], four: pegs[3]}
    end

    def compare (code)
      #paramenter is a hash representing a row.
      puts "Comparing Codes ......"
      @row.each do |pos, color|
        puts "Position #{pos} is #{color}"
        if code.row.has_value?(color)
          if pos == code.row.key(color)
            code.black += 1
          else
            code.white += 1
          end
        end
      end
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
