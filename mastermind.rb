# Mastermind Game - The Odin TheOdinProject Intermediate Ruby Project 2
class Line
  attr_accessor :peg_1, :peg_2, :peg_3, :peg_4

  def initialize
    @peg_1 = Struct.new(:color, :position)
    @peg_2 = Struct.new(:color, :position)
    @peg_3 = Struct.new(:color, :position)
    @peg_4 = Struct.new(:color, :position)

  end
end # Line

class Code_Master

  attr_accessor :master_code

  def initialize
    @master_code = Line.new
  end

  def create_code
    #Randonly generate a 4 peg code, assign a colour and postion (1 - 4)
    @master_code.peg_1.position = rand(1..4)
    get_color(@master_code.peg_1)
    @master_code.peg_2.position = rand(1..4)
    get_color(@master_code.peg_2)
    @master_code.peg_1.position = rand(1..4)
    get_color(@master_code.peg_3)
    @master_code.peg_1.position = rand(1..4)
    get_color(@master_code.peg_4)
  end

  def guess_code (code)

  end

  def feedback

  end

  def get_color (peg)
    col = rand(1..4)
    case col
      when 1
        peg.color = "Red"
      when 2
        peg.color = "Blue"
      when 3
        peg.color = "Green"
      else
        peg.color = "Yellow"
      end
end # Code


master_code = Code.new
master_code.create_code
puts "Master Code has been generated - try to guess it in 12 turns!"
turn = 0
while turn < 12
  line = {}
  4.times do |g|
    print "Guess peg #{g} colore (Red, Green, Blue or Yellow): "
    line[g] = gets.chomp
    p line
  end
  master_code.guess(line)
end
