# Mastermind Game - The Odin TheOdinProject Intermediate Ruby Project 2


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
    #paramenter is a hash representing a row
    @row.each do |pos, color|
      if code.row.has_value?(color)
        if pos == code.row.key(color)
          code.black += 1
        else
          code.white += 1
        end
      end
    end
  end

  def has_won?
    @black == 4 ? true : false
  end

end # Code

class Code_Master < Code

  def initialize
    create_code
    @feedback = Array.new(4, " ")
    @correct_code = false
    @black = 0
    @white = 0
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
    #print @row
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

class AI_Code_Breaker < Code_Master

	# Object that can create codes based on the results of the last guess.
	attr_accessor :master_code, :history, :pegs

	def initialize master_code
		super
		@history = Array.new
		@master_code = master_code
		self.create_code #initial random guess
	end

	def break_code

		#check how many turns have been taken
		while @history.length < 12
			#compare current row
			@master_code.compare(self)
			if has_won?
				return true
			else
				#create new row based on feedback
				case @black

					when 0
						#reorder the hash keys - then #rehash


					when 1

					when 2

					when 3

				end

			#has_won? If not then update history
			 update_history
      end
	   end
		 return false
	end

	def update_history
		feedback = {black: @black, white: @white}
		guess = [@row,feedback]
		@history.push(guess)
	end


	private :master_code, :break_code

end
