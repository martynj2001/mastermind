# Mastermind Game - The Odin TheOdinProject Intermediate Ruby Project 2
module Mastermind

  class Code

    attr_accessor :row :feedback

    def initialize
      @feedback = Struct.new(:one, :two, :three, :four)
    end

    def create_code (pegs)
      @row = {one: pegs[0], two: pegs[1], three: pegs[2], four: peg[4]}
    end

    def compare_codes (master, guess)

    end

    def feedback

    end

  end # Line

  class Code_Master < Code

    @@peg = nil

    def initialize
      create_code
    end

    def create_code # overide parent
      #Randonly generate a 4 peg code, assign a colour and postion (1 - 4)
      
      @row = {one: get_color, two: get_color, three: get_color, four: get_color}
    end

    def get_color
      col = rand(1..4)
      case col
        when 1
          @@peg = "Red"
        when 2
          @@peg = "Blue"
        when 3
          @@peg= "Green"
        else
          @@peg = "Yellow"
        end
      end

      private :create_code, :get_color
  end # Code
end #Mastermind
