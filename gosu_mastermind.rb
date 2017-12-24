  require 'gosu'


  module ZOrder
    BACKGROUND, GRID, PEGS, UI = *0..3
  end

  class Mastermind < Gosu::Window

    DOT_WIDTH = 60
    DOT_HEIGHT = 60
    RED_X, RED_Y = 100, 350
    BLUE_X, BLUE_Y = 150, 350
    GREEN_X, GREEN_Y = 470, 350
    YELLOW_X, YELLOW_Y = 520, 350


    attr_accessor :prompt_text, :guess, :peg_selected, :pegs

    def initialize
      super 640, 480
      self.caption = "Mastermind"
      @background_image = Gosu::Image.new("media/grey_background.jpg", :tileable => true)
      #@button = Gosu::Image.new("media/button.png", :tileable => true)

      @red_peg = Gosu::Image.new("media/red_dot.png", :tileable => true)
      @blue_peg = Gosu::Image.new("media/blue_dot.png", :tileable => true)
      @green_peg = Gosu::Image.new("media/green_dot.png", :tileable => true)
      @yellow_peg = Gosu::Image.new("media/yellow_dot.png", :tileable => true)
      @title_font = Gosu::Font.new(32, name: "Nimbus Mono L")
      @peg_image = Array.new
      @prompt_text = "Welcome to Mastermind..... Press Enter to continue."
      @prompt, @guess_no = Gosu::Font.new(20, name: "Nimbus Mono L")
      @guess = 0
      @peg_selected = false

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
      @prompt.draw(@prompt_text, 10, 420, ZOrder::UI, 1.0, 1.0, Gosu::Color::GREEN)
      #@button.draw(60, 345, ZOrder::UI)
      #Peg selction buttons
      @red_peg.draw(RED_X, RED_Y, ZOrder::PEGS)
      @blue_peg.draw(BLUE_X, BLUE_Y, ZOrder::PEGS)
      @green_peg.draw(GREEN_X, GREEN_Y, ZOrder::PEGS)
      @yellow_peg.draw(YELLOW_X, YELLOW_Y, ZOrder::PEGS)

      if peg_selected
        puts "Pegs = #{@peg_image.length}"
        peg_x = 200
          @peg_image.each do |img|
            unless img == nil || peg_x >= 400
              img.draw(peg_x += 50, 350, ZOrder::PEGS)
            end
          end
      end

      @title_font.draw("Mastermind", 250, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
    end

    def button_down(id)
      if id == Gosu::KB_RETURN
        if @guess < 1
          @prompt_text = "Use the mouse to select your code.and press Enter to confirm"
          @guess += 1
        else
          @prompt_text = "You have had #{@guess} attempts"
          @guess += 1
        end
      elsif id == Gosu::MS_LEFT
        puts "Mouse clicked - MS_LEFT"
        on_click
      end
    end

    # Hit-test for selecting a Peg with the mouse.
    def on_click
      if @peg_image.length < 4
        if mouse_x.to_i.between?(RED_X - DOT_WIDTH, RED_X + DOT_WIDTH) && mouse_y.to_i.between?(RED_Y - DOT_HEIGHT, RED_Y + DOT_HEIGHT)
          @peg_image << @red_peg
          puts "Red selected and clicked"
        elsif mouse_x.to_i.between?(BLUE_X - DOT_WIDTH, BLUE_X + DOT_WIDTH) && mouse_y.to_i.between?(BLUE_Y - DOT_HEIGHT, BLUE_Y + DOT_HEIGHT)
          @peg_image << @blue_peg
          puts "Blue selcted and clicked"
        elsif mouse_x.to_i.between?(GREEN_X - DOT_WIDTH, GREEN_X + DOT_WIDTH) && mouse_y.to_i.between?(GREEN_Y - DOT_HEIGHT, GREEN_Y + DOT_HEIGHT)
          @peg_image << @green_peg
          puts "Green selected and clicked"
        elsif mouse_x.to_i.between?(YELLOW_X - DOT_WIDTH, YELLOW_X + DOT_WIDTH) && mouse_y.to_i.between?(YELLOW_Y - DOT_HEIGHT, YELLOW_Y + DOT_HEIGHT)
          @peg_image << @yellow_peg
          puts "Yellow selected and clicked"
        end
        @peg_selected = true
      end
    end

  end

  Mastermind.new.show
