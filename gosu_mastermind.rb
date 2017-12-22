  require 'gosu'

  module ZOrder
    BACKGROUND, GRID, PEGS, UI = *0..3
  end

  class Mastermind < Gosu::Window

    attr_accessor :prompt_text, :guess

    def initialize
      super 640, 480
      self.caption = "Mastermind"
      @background_image = Gosu::Image.new("media/grey_background.jpg", :tileable => true)
      @button = Gosu::Image.new("media/button.png", :tileable => true)

      @red_peg = Gosu::Image.new("media/red_dot.png", :tileable => true)
      @blue_peg = Gosu::Image.new("media/blue_dot.png", :tileable => true)
      @green_peg = Gosu::Image.new("media/green_dot.png", :tileable => true)
      @yellow_peg = Gosu::Image.new("media/yellow_dot.png", :tileable => true)
      @title_font = Gosu::Font.new(32, name: "Nimbus Mono L")
      @peg_image = [:red, :blue, :green, :yellow]
      @prompt_text = "Welcome to Mastermind..... Press Enter to continue."
      @prompt, @guess_no = Gosu::Font.new(20, name: "Nimbus Mono L")

    end

    def needs_cursor?
      true
    end

    def update
      @prompt_text = "The master code has been set. Use the mouse to select your code"

    end

    def draw
      @background_image.draw(0,0,ZOrder::BACKGROUND)
      self.draw_line(0, 330, Gosu::Color::BLACK, 640, 330, Gosu::Color::BLACK, ZOrder::UI)
      self.draw_line(200, 0, Gosu::Color::BLACK, 200, 480, Gosu::Color::BLACK, ZOrder::UI)
      self.draw_line(450, 0, Gosu::Color::BLACK, 450, 480, Gosu::Color::BLACK, ZOrder::UI)
      @prompt.draw(@prompt_text, 10, 420, ZOrder::UI, 1.0, 1.0, Gosu::Color::GREEN)
      @button.draw(60, 345, ZOrder::UI)
      @red_peg.draw(250,350,ZOrder::PEGS)
      @blue_peg.draw(300,350,ZOrder::PEGS)
      @green_peg.draw(350,350,ZOrder::PEGS)
      @yellow_peg.draw(400,350,ZOrder::PEGS)
      @title_font.draw("Mastermind", 250, 10, ZOrder::UI, 1.0, 1.0, Gosu::Color::BLACK)
      #@input_title_font.draw(@prompt_text, 10, 400, ZOrder::UI, 1.0, 1.0, Gosu::Color::GREEN)
    end

    def button_down(id)

    end

    # Hit-test for selecting a Peg with the mouse.
    def under_point?(mouse_x, mouse_y)
      mouse_x > x - PADDING and mouse_x < x + width + PADDING and
        mouse_y > y - PADDING and mouse_y < y + height + PADDING
    end

  end

  Mastermind.new.show
