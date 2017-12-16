# Mastermind Game - The Odin TheOdinProject Intermediate Ruby Project 2
module Mastermind

  class Code

    attr_accessor :row, :feedback

    def initialize
      @feedback = Array.new(4)
    end

    def create_code (pegs)
      @row = {one: pegs[0], two: pegs[1], three: pegs[2], four: peg[3]}
    end

    def compare (g_row)
      #paramenter is a hash representing a row.
      @row.each do |pos, color|
        if g_row[pos] == color
          @feedback << "BLACK"
        elsif g_row.include?(color)
          @feedback << "WHITE"
        end
        @feedback.sort
      end

    end

    def feedback(loc, type)



      end

    end

  end # Line

  class Code_Master < Code

    def initialize
      create_code
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
