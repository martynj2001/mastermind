  require 'gosu'
  require './mastermind.rb'

  module ZOrder
    BACKGROUND, GRID, PEGS, UI, START = *0..4
  end

  class Player_Code < Code

    attr_accessor :peg_imgs, :guess

    def initialize
      super
      @peg_imgs = Array.new
      @guess = 0
    end
  end


  class Mastermind < Gosu::Window

    DOT_WIDTH = 30
    DOT_HEIGHT = 30
    RED_X, RED_Y = 100, 350
    BLUE_X, BLUE_Y = 150, 350
    GREEN_X, GREEN_Y = 470, 350
    YELLOW_X, YELLOW_Y = 520, 350


    attr_accessor :prompt_text, :guess, :peg_selected, :pegs, :history, :master_code

    def initialize

      super 640, 480
      self.caption = "Mastermind"

      @background_image = Gosu::Image.new("media/grey_background.jpg", :tileable => true)
      @red_peg = Gosu::Image.new("media/red_dot.png", :tileable => true)
      @blue_peg = Gosu::Image.new("media/blue_dot.png", :tileable => true)
      @green_peg = Gosu::Image.new("media/green_dot.png", :tileable => true)
      @yellow_peg = Gosu::Image.new("media/yellow_dot.png", :tileable => true)
      @white_sq = Gosu::Image.new("media/white_sq.png", :tileable => true)
      @black_sq = Gosu::Image.new("media/black_sq.png", :tileable => true)

      @title_font = Gosu::Font.new(32, name: "Nimbus Mono L")
      @prompt = Gosu::Font.new(25, name: "Nimbus Mono L")
      @guess_no = Gosu::Font.new(25, name: "Nimbus Mono L")
      @fb_instr_b = Gosu::Font.new(20, name: "Nimbus Mono L")
      @fb_instr_w = Gosu::Font.new(20, name: "Nimbus Mono L")
      @winner = Gosu::Font.new(50, name: "Nimbus Mono L")

      @peg_image = Array.new
      @pegs = Array.new
      @history = Array.new

      @prompt_text = "Welcome to Mastermind..... Press Enter to continue."
      @guess = 0
      @peg_selected = false
      @won = false
      @lose = false
      @master_code = Code_Master.new

    end

    def needs_cursor?
      true
    end

    def update

    end

    def draw
      @background_image.draw(0,0,ZOrder::BACKGROUND)
      self.draw_line(0, 330, Gosu::Color::BLACK, 640, 330, Gosu::Color::BLACK, ZOrder::UI)
      self.draw_line(200, 0, Gosu::Color::BLACK, 200, 480, Gosu::Color::BLACK, ZOrder::UI)
      self.draw_line(450, 0, Gosu::Color::BLACK, 450, 480, Gosu::Color::BLACK, ZOrder::UI)
      @title_font.draw("Mastermind", 250, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
      @prompt.draw(@prompt_text, 10, 400, ZOrder::UI, 1.0, 1.0, Gosu::Color::GREEN)
      #Peg selection buttons
      @red_peg.draw(RED_X, RED_Y, ZOrder::PEGS)
      @blue_peg.draw(BLUE_X, BLUE_Y, ZOrder::PEGS)
      @green_peg.draw(GREEN_X, GREEN_Y, ZOrder::PEGS)
      @yellow_peg.draw(YELLOW_X, YELLOW_Y, ZOrder::PEGS)

      # Draw any previous attempts with feedback on a new line.
      if @history.length > 0
        @fb_instr_b.draw("Black Pegs - Right Colour, right position", 10, 430, ZOrder::UI, 1.0, 1.0, Gosu::Color::GREEN)
        @fb_instr_b.draw("White Pegs - Right Colour, wrong position", 10, 450, ZOrder::UI, 1.0, 1.0, Gosu::Color::GREEN)
        line_y = 325
        @history.each do |code|
          line_x, b_x, w_x = 185, 185, 435
          line_y -= 45
          code.peg_imgs.each{|img| img.draw(line_x += 50, line_y, ZOrder::PEGS)}
          code.black.times {@black_sq.draw(b_x -= 40,line_y, ZOrder::PEGS)}
          code.white.times {@white_sq.draw(w_x += 40,line_y, ZOrder::PEGS)}
          @guess_no.draw(code.guess.to_s, 25, (line_y + 5), ZOrder::PEGS, 1.0, 1.0, Gosu::Color::BLACK)
        end
      end

      if peg_selected
        peg_x = 175
          @peg_image.each do |img|
            unless img == nil || peg_x >= 400
              img.draw(peg_x += 50, 350, ZOrder::PEGS)
            end
          end
      end

      if @won
        @winner.draw("You Win!", 240, 160, ZOrder::UI, 1.0, 1.0, Gosu::Color::RED)
      elsif @lose
        @winner.draw("You Lost", 240, 160, ZOrder::UI, 1.0, 1.0, Gosu::Color::RED)
      end
    end

    def button_down(id)
      if id == Gosu::KB_RETURN
        if @guess < 1
          @prompt_text = "Use the mouse to select your code and press Enter to confirm"
          @guess += 1
        else
          unless @peg_image.length < 4
            @guess += 1
            player = Player_Code.new
            player.guess = @guess - 1
            player.create_code(@pegs)
            @master_code.compare(player)
            @prompt_text = "You have had #{player.guess} attempts"
            if player.has_won?
              @prompt_text = "Congratulations you have broken the code in #{player.guess} turns."
              peg_selected = false
              @history.clear
              @won = true
            elsif player.guess == 12
              peg_selected = false
              @history.clear
              @prompt_text = "You have exceeded your available turns..... you lose!"
              @lose = true
            else
              #need to display feedback.
              @peg_selected = false
              4.times { |i| player.peg_imgs[i] = @peg_image[i] }
              @history.shift(5) if @history.length >= 6
              @history << player
              @peg_image.clear
              @pegs.clear
            end
          end

        end
      elsif id == Gosu::MS_LEFT
        on_click
      end
    end

    # Hit-test for selecting a Peg with the mouse.
    def on_click
      if @peg_image.length < 4
        if mouse_x.to_i.between?(RED_X, RED_X + DOT_WIDTH) && mouse_y.to_i.between?(RED_Y, RED_Y + DOT_HEIGHT)
          @peg_image << @red_peg
          @pegs << "Red"
        elsif mouse_x.to_i.between?(BLUE_X, BLUE_X + DOT_WIDTH) && mouse_y.to_i.between?(BLUE_Y , BLUE_Y + DOT_HEIGHT)
          @peg_image << @blue_peg
          @pegs << "Blue"
        elsif mouse_x.to_i.between?(GREEN_X, GREEN_X + DOT_WIDTH) && mouse_y.to_i.between?(GREEN_Y, GREEN_Y + DOT_HEIGHT)
          @peg_image << @green_peg
          @pegs << "Green"
        elsif mouse_x.to_i.between?(YELLOW_X, YELLOW_X + DOT_WIDTH) && mouse_y.to_i.between?(YELLOW_Y, YELLOW_Y + DOT_HEIGHT)
          @peg_image << @yellow_peg
          @pegs << "Yellow"
        end
      end
      @peg_selected = true
    end

  end

  Mastermind.new.show
